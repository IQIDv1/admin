import type { Metadata } from "next";
import AnalyticsDashboard from "./analytics-dashboard";
import { APP_NAME } from "@/lib/constants";

export const metadata: Metadata = {
  title: `Analytics | ${APP_NAME}`,
  description: "Monitor your email agent's performance metrics",
};

export default async function AnalyticsPage() {
  return <AnalyticsDashboard />;
}
