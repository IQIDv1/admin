import { NextRequest, NextResponse } from 'next/server';
import { AppError, handleApiError } from '@/lib/errorHandler';
import { createServiceRoleClient } from '@/lib/supabase/server';
import { DATABASE_TABLES } from '@/lib/constants';

export async function POST(request: NextRequest): Promise<NextResponse> {
  try {
    const domain: string = (await request.json())?.domain?.trim().toLowerCase();

    if (!domain) throw new AppError('Invalid domain', 400);

    const supabaseServiceRoleClient = await createServiceRoleClient();

    const { data: organizationDomain, error: organizationError } = await supabaseServiceRoleClient
      .from(DATABASE_TABLES.ORGANIZATIONS)
      .select('domain')
      .eq('domain', domain)
      .single();

    if (
      organizationError ||
      !organizationDomain ||
      (organizationDomain && !organizationDomain.domain)
    ) {
      console.error(organizationError);
      throw new AppError('Invalid domain', 400);
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    return handleApiError(request, error);
  }
}
