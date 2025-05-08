import type { Metadata } from "next";
import SettingsPanel from "./settings-panel";
import { APP_NAME } from "@/lib/constants";

export const metadata: Metadata = {
  title: `Settings | ${APP_NAME}`,
  description: "Configure your email agent settings",
};

export default async function SettingsPage() {
  return <SettingsPanel />;
}
