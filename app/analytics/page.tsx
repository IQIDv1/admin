import type { Metadata } from "next"
import { DashboardShell } from "@/components/dashboard-shell"
import { AnalyticsDashboard } from "@/components/analytics-dashboard"

export const metadata: Metadata = {
  title: "Analytics | Agent Dashboard",
  description: "Monitor your email agent's performance metrics",
}

export default function AnalyticsPage() {
  return (
    <DashboardShell>
      <AnalyticsDashboard />
    </DashboardShell>
  )
}

