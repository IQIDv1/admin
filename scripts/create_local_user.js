// @ts-check
import { createClient } from '@supabase/supabase-js'
import { EMAIL, PASSWORD } from './local-user-credentials.js'

// Point to your local GoTrue:
const SUPABASE_URL='http://127.0.0.1:54321'
const SUPABASE_SERVICE_ROLE_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU';

const supabaseAdmin = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

async function main() {
  console.log('Creating local developer user...')
  const { data: { user }, error } = await supabaseAdmin.auth.admin.createUser({
    email: EMAIL,
    password: PASSWORD,
    email_confirm: true,    // skip “confirm email” step in local dev
    user_metadata: {
      first_name: 'Local',
      last_name: 'Dev'
    }
  })

  if (error) {
    console.error('Error creating user:', error.message)
    process.exit(1)
  }

  if (!user) {
    console.error('No user returned from createUser')
    process.exit(1)
  }

  console.log('➜ Created auth.user: ', user.id, user.email)
  process.exit(0)
}

main()
