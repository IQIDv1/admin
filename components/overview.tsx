"use client"

import { useState } from "react"
import { Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis, Legend } from "recharts"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs"

const hourlyData = [
  { time: "00:00", emailsSent: 12, dataRetrieved: 45, draftsCreated: 8 },
  { time: "01:00", emailsSent: 8, dataRetrieved: 30, draftsCreated: 5 },
  { time: "02:00", emailsSent: 5, dataRetrieved: 20, draftsCreated: 3 },
  // ... add more hourly data points
  { time: "23:00", emailsSent: 15, dataRetrieved: 50, draftsCreated: 10 },
]

const weeklyData = [
  { day: "Mon", emailsSent: 120, dataRetrieved: 450, draftsCreated: 80 },
  { day: "Tue", emailsSent: 150, dataRetrieved: 500, draftsCreated: 95 },
  { day: "Wed", emailsSent: 180, dataRetrieved: 550, draftsCreated: 110 },
  { day: "Thu", emailsSent: 160, dataRetrieved: 520, draftsCreated: 100 },
  { day: "Fri", emailsSent: 140, dataRetrieved: 480, draftsCreated: 90 },
  { day: "Sat", emailsSent: 90, dataRetrieved: 300, draftsCreated: 60 },
  { day: "Sun", emailsSent: 70, dataRetrieved: 250, draftsCreated: 45 },
]

export function Overview() {
  const [timeRange, setTimeRange] = useState("24h")

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-purple">Overview</CardTitle>
        <CardDescription>Agent activity over the last {timeRange === "24h" ? "24 hours" : "week"}</CardDescription>
        <Tabs value={timeRange} onValueChange={setTimeRange}>
          <TabsList>
            <TabsTrigger value="24h" className="text-purple hover:bg-purple/10">
              Last 24 Hours
            </TabsTrigger>
            <TabsTrigger value="week" className="text-purple hover:bg-purple/10">
              Last Week
            </TabsTrigger>
          </TabsList>
        </Tabs>
      </CardHeader>
      <CardContent>
        <ResponsiveContainer width="100%" height={350}>
          <LineChart data={timeRange === "24h" ? hourlyData : weeklyData}>
            <XAxis
              dataKey={timeRange === "24h" ? "time" : "day"}
              stroke="#888888"
              fontSize={12}
              tickLine={false}
              axisLine={false}
            />
            <YAxis
              stroke="#888888"
              fontSize={12}
              tickLine={false}
              axisLine={false}
              tickFormatter={(value) => `${value}`}
            />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="emailsSent" stroke="hsl(267, 100%, 50%)" name="Emails Sent" />
            <Line type="monotone" dataKey="dataRetrieved" stroke="hsl(267, 100%, 70%)" name="Data Retrieved" />
            <Line type="monotone" dataKey="draftsCreated" stroke="hsl(267, 100%, 90%)" name="Drafts Created" />
          </LineChart>
        </ResponsiveContainer>
      </CardContent>
    </Card>
  )
}

