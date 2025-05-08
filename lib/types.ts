import type { Database } from "./database.types";

export type Organization = Database["public"]["Tables"]["organizations"]["Row"];
export type Member = Database["public"]["Tables"]["members"]["Row"];
export type Invite = Database["public"]["Tables"]["invites"]["Row"];

export type THEMES = "dark" | "light";

// export type ChatSession = Database["public"]["Tables"]["chat_sessions"]["Row"];
// export type ChatMessage = Database["public"]["Tables"]["chat_messages"]["Row"];
// export type Document = Database["public"]["Tables"]["documents"]["Row"];
// export type Feedback = Database["public"]["Tables"]["feedback"]["Row"];
// export type Profile = Database["public"]["Tables"]["profiles"]["Row"];
// export type UserRole = "user" | "admin";
// export type MessageRole = "user" | "assistant" | "system";
// export type FeedbackRating = "positive" | "negative";

// eslint-disable-next-line @typescript-eslint/no-explicit-any
