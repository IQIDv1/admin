import { NextRequest, NextResponse } from 'next/server';
import { AppError, handleApiError } from '@/lib/errorHandler';
import { createClient, createServiceRoleClient } from '@/lib/supabase/server';
import { DATABASE_TABLES } from '@/lib/constants';

export async function GET(request: NextRequest): Promise<NextResponse> {
  console.log('running callback');
  try {
    const supabaseClient = await createClient();
    const supabaseServiceRoleClient = await createServiceRoleClient();
    const code: string = request.nextUrl.searchParams.get('code') || '';
    const attempted_email: string =
      request.nextUrl.searchParams.get('attempted_email')?.trim()?.toLowerCase() || '';

    if (!code) {
      throw new AppError('Missing auth code', 400, '/login?error=missing_code');
    }

    const { error: codeExchangeError } = await supabaseClient.auth.exchangeCodeForSession(code);

    if (codeExchangeError) {
      throw new AppError('Failed to exchange auth code', 400, '/login?error=invalid_code');
    }

    const {
      data: { user },
      error
    } = await supabaseClient.auth.getUser();

    console.log('USER', user);

    if (error || !user || !user.email) {
      console.log('ERR', error);
      throw new AppError(
        'You must be invited to access this organization',
        403,
        '/login?error=unauthorized'
      );
    }

    if (user?.identities && user.identities[0]) {
      console.log('IDENTITY DATA', user.identities[0]?.identity_data);
    }

    const email = user.email.trim().toLowerCase();
    const domain = email.split('@')[1];

    if (email !== attempted_email) {
      await supabaseClient.auth.signOut();
      // Possible TODO: delete the actual user if this was a mistake
      //                and the user does not exist
      throw new AppError(
        'You are signed into the wrong account',
        400,
        '/login?error=email_mismatch'
      );
    }

    // Step 1: Find matching organization
    const { data: organizationData, error: organizationError } = await supabaseServiceRoleClient
      .from(DATABASE_TABLES.ORGANIZATIONS)
      .select('id')
      .eq('domain', domain)
      .single();

    console.log('ORG DATA', organizationData);

    if (!organizationData || organizationError) {
      console.log('ORG ERROR', organizationError);
      throw new AppError(
        'No organization found under your domain',
        403,
        '/login?error=organization_domain'
      );
    }

    // Step 2: Check if user already exists in members / returning user
    const { data: existingMember, error: existingMemberError } = await supabaseServiceRoleClient
      .from(DATABASE_TABLES.MEMBERS)
      .select('id, active')
      .eq('id', user.id)
      .single();

    console.log('Existing member response', existingMember);
    console.log('Existing member error', existingMemberError);

    if (existingMember) {
      if (!existingMember.active) {
        await supabaseClient.auth.signOut();
        throw new AppError('Your account has been deactivated', 403, '/login?error=deactivated');
      }

      console.log('member exists');

      return NextResponse.redirect(new URL('/', request.url));
    }

    // Step 3: Check if there's a valid invite
    const { data: inviteData, error: inviteError } = await supabaseServiceRoleClient
      .from(DATABASE_TABLES.INVITES)
      .select('*')
      .eq('email', email)
      .eq('organization_id', organizationData.id)
      .eq('accepted', false)
      .gt('expires_at', new Date().toISOString())
      .single();

    console.log('INVITE DATA', inviteData);

    if (!inviteData || inviteError) {
      console.log('invite error', inviteError);
      throw new AppError(
        'You must be invited to access this organization',
        403,
        '/login?error=unauthorized'
      );
    }

    // Step 4: Create member from invite
    const { error: createMemberError } = await supabaseServiceRoleClient
      .from(DATABASE_TABLES.MEMBERS)
      .insert({
        id: user.id,
        organization_id: organizationData.id,
        email,
        first_name: user.user_metadata?.first_name || '',
        last_name: user.user_metadata?.last_name || '',
        role: inviteData.role,
        active: true
      });

    if (createMemberError) {
      console.log('create member error', createMemberError);
      throw new Error();
    }

    await supabaseServiceRoleClient
      .from(DATABASE_TABLES.INVITES)
      .update({ accepted: true })
      .eq('id', inviteData.id);

    console.log('creating member completed');

    return NextResponse.redirect(new URL('/', request.url));
  } catch (error) {
    if (error instanceof AppError) return handleApiError(request, error);
    return NextResponse.redirect(new URL('/login?error=general', request.url));
  }
}
