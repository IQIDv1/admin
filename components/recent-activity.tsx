"use client"

import { CheckCircle2, Clock } from "lucide-react"

interface Activity {
  id: string
  type: string
  status: "completed" | "pending"
  timestamp: string
  description: string
}

const recentActivities: Activity[] = [
  {
    id: "1",
    type: "Email Response",
    status: "completed",
    timestamp: "2 minutes ago",
    description: "Processed FAFSA inquiry from student",
  },
  {
    id: "2",
    type: "Document Review",
    status: "pending",
    timestamp: "5 minutes ago",
    description: "Reviewing scholarship eligibility documents",
  },
  {
    id: "3",
    type: "Email Response",
    status: "completed",
    timestamp: "10 minutes ago",
    description: "Answered loan disbursement question",
  },
  {
    id: "4",
    type: "Document Review",
    status: "completed",
    timestamp: "15 minutes ago",
    description: "Verified income documentation",
  },
  {
    id: "5",
    type: "Email Response",
    status: "completed",
    timestamp: "20 minutes ago",
    description: "Processed grant application inquiry",
  },
  {
    id: "6",
    type: "Document Review",
    status: "pending",
    timestamp: "25 minutes ago",
    description: "Reviewing dependency override request",
  },
  {
    id: "7",
    type: "Email Response",
    status: "completed",
    timestamp: "30 minutes ago",
    description: "Answered verification process question",
  },
  {
    id: "8",
    type: "Document Review",
    status: "completed",
    timestamp: "35 minutes ago",
    description: "Processed SAP appeal documentation",
  },
  {
    id: "9",
    type: "Email Response",
    status: "completed",
    timestamp: "40 minutes ago",
    description: "Responded to award letter inquiry",
  },
  {
    id: "10",
    type: "Document Review",
    status: "pending",
    timestamp: "45 minutes ago",
    description: "Reviewing professional judgment request",
  },
]

export function RecentActivity() {
  return (
    <div className="space-y-8">
      {recentActivities.map((activity) => (
        <div key={activity.id} className="flex items-center">
          <div className="flex items-center justify-center rounded-full border-2 border-muted p-2">
            {activity.status === "completed" ? (
              <CheckCircle2 className="h-4 w-4 text-green-500" />
            ) : (
              <Clock className="h-4 w-4 text-yellow-500" />
            )}
          </div>
          <div className="ml-4 space-y-1">
            <p className="text-sm font-medium leading-none">{activity.type}</p>
            <p className="text-sm text-muted-foreground">{activity.description}</p>
            <p className="text-xs text-muted-foreground">{activity.timestamp}</p>
          </div>
        </div>
      ))}
    </div>
  )
}

