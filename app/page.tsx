import type { Metadata } from "next"
import { DashboardShell } from "@/components/dashboard-shell"
import { InteractionsList } from "@/components/interactions-list"

export const metadata: Metadata = {
  title: "Agent Dashboard",
  description: "Monitor and manage your email agent's performance",
}

export default function DashboardPage() {
  return (
    <DashboardShell>
      <InteractionsList />
    </DashboardShell>
  )
}

