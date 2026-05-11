import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://ievrppxrjzbxfedtcemq.supabase.co'
const supabaseKey = 'sb_publishable_-rBpx_gnW6n2JQXcIH7OnQ_Fz_4PDEC'

export const supabase = createClient(supabaseUrl, supabaseKey)