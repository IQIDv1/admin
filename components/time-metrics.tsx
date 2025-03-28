"use client"

import { Bar, BarChart, ResponsiveContainer, XAxis, YAxis } from "recharts"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

const data = [
  {
    name: "Email Processing",
    manual: 15,
    automated: 3,
  },
  {
    name: "Document Review",
    manual: 20,
    automated: 5,
  },
  {
    name: "Response Generation",
    manual: 25,
    automated: 4,
  },
  {
    name: "Follow-up Tasks",
    manual: 18,
    automated: 3,
  },
  {
    name: "Record Updates",
    manual: 12,
    automated: 2,
  },
]

export function TimeMetrics() {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-purple">Time Savings Analysis</CardTitle>
        <CardDescription>Comparison of manual vs automated processing times (in minutes)</CardDescription>
      </CardHeader>
      <CardContent className="pl-2">
        <ResponsiveContainer width="100%" height={350}>
          <BarChart data={data}>
            <XAxis dataKey="name" stroke="#888888" fontSize={12} tickLine={false} axisLine={false} />
            <YAxis
              stroke="#888888"
              fontSize={12}
              tickLine={false}
              axisLine={false}
              tickFormatter={(value) => `${value}m`}
            />
            <Bar dataKey="manual" fill="hsl(267, 100%, 70%)" radius={[4, 4, 0, 0]} />
            <Bar dataKey="automated" fill="hsl(267, 100%, 50%)" radius={[4, 4, 0, 0]} />
          </BarChart>
        </ResponsiveContainer>
      </CardContent>
    </Card>
  )
}

