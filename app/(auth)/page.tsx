import type { Metadata } from "next";
import InteractionsList from "@/components/interactions-list";
import { APP_NAME } from "@/lib/constants";

export const metadata: Metadata = {
  title: `Interactions | ${APP_NAME}`,
  description: "Monitor and manage your email agent's performance",
};

export default async function InteractionsPage() {
  return <InteractionsList />;
}
