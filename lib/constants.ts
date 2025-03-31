export const APP_NAME = "IQID Admin";
export const APP_DESCRIPTION = "Admin dashboard for IQID's Quiddy";
export const APP_ICON = "/assets/icons/favicon.ico";
export const APP_LOGO = "/assets/images/IQID-logo.png";
export const APP_LOGO_CIRCLE = "/assets/images/IQID-logo-round.png";

export const THEMES = {
  DARK: "dark",
  LIGHT: "light",
  SYSTEM: "system",
} as const;

export const OPENAI_COMPLETIONS_MODEL = "gpt-4-turbo";
export const OPENAI_EMBEDDINGS_MODEL = "text-embedding-ada-002";

export const STATES = [
  "alabama",
  "alaska",
  "arizona",
  "arkansas",
  "california",
  "colorado",
  "connecticut",
  "delaware",
  "florida",
  "georgia",
  "hawaii",
  "idaho",
  "illinois",
  "indiana",
  "iowa",
  "kansas",
  "kentucky",
  "louisiana",
  "maine",
  "maryland",
  "massachusetts",
  "michigan",
  "minnesota",
  "mississippi",
  "missouri",
  "montana",
  "nebraska",
  "nevada",
  "new hampshire",
  "new jersey",
  "new mexico",
  "new york",
  "north carolina",
  "north dakota",
  "ohio",
  "oklahoma",
  "oregon",
  "pennsylvania",
  "rhode island",
  "south carolina",
  "south dakota",
  "tennessee",
  "texas",
  "utah",
  "vermont",
  "virginia",
  "washington",
  "west virginia",
  "wisconsin",
  "wyoming",
] as const;

export const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;
export const NEXT_PUBLIC_SUPABASE_ANON_KEY =
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;
export const NEXT_PUBLIC_SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!;
export const OPENAI_API_KEY = process.env.OPENAI_API_KEY!;

if (
  !SUPABASE_SERVICE_ROLE_KEY ||
  !NEXT_PUBLIC_SUPABASE_ANON_KEY ||
  !NEXT_PUBLIC_SUPABASE_URL ||
  !OPENAI_API_KEY
) {
  throw new Error("Missing required environment variables");
}
