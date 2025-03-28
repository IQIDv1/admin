"use client"

import { useState } from "react"
import { format } from "date-fns"
import { ArrowRight, CheckCircle2, Clock, Filter, MoreVertical, Search, Clipboard, Edit, Trash2 } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Separator } from "@/components/ui/separator"

export function InteractionsList() {
  const [selectedInteraction, setSelectedInteraction] = useState<string | null>(null)

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div className="space-y-1">
          <h2 className="text-2xl font-semibold tracking-tight">Interactions</h2>
          <p className="text-sm text-muted-foreground">Review and manage recent student interactions</p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" size="sm">
            <Filter className="mr-2 h-4 w-4" />
            Filter
          </Button>
          <Select defaultValue="all">
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Status" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Interactions</SelectItem>
              <SelectItem value="pending">Pending</SelectItem>
              <SelectItem value="completed">Completed</SelectItem>
            </SelectContent>
          </Select>
          <div className="relative">
            <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
            <Input type="search" placeholder="Search interactions..." className="w-[200px] pl-8" />
          </div>
        </div>
      </div>
      <div className="grid gap-4">
        {interactions.map((interaction) => (
          <Card key={interaction.id}>
            <CardHeader className="p-4">
              <div className="flex items-start justify-between">
                <div className="space-y-1.5">
                  <CardTitle className="text-base">
                    <span className="font-mono text-sm font-normal text-muted-foreground">
                      {format(interaction.timestamp, "HH:mm")}
                    </span>{" "}
                    - {interaction.subject}
                  </CardTitle>
                  <p className="text-sm text-muted-foreground line-clamp-2">{interaction.message}</p>
                </div>
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="sm" className="h-8 w-8 p-0">
                      <MoreVertical className="h-4 w-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end">
                    <DropdownMenuItem>View full history</DropdownMenuItem>
                    <DropdownMenuItem>Export conversation</DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
            </CardHeader>
            {selectedInteraction === interaction.id && (
              <CardContent className="border-t bg-muted/50 px-4 py-3">
                <div className="space-y-4">
                  <div className="space-y-2">
                    <h4 className="font-medium leading-none">Audit Trail</h4>
                    <div className="text-sm text-muted-foreground">
                      {interaction.auditTrail.map((action, i) => (
                        <div key={i} className="flex items-center gap-2 py-1">
                          <CheckCircle2 className="h-4 w-4 text-green-500" />
                          <span>{action}</span>
                        </div>
                      ))}
                    </div>
                  </div>
                  {interaction.userActionTaken && (
                    <>
                      <Separator />
                      <div className="space-y-2">
                        <h4 className="font-medium leading-none">User Action Taken</h4>
                        <div className="flex items-center gap-2 py-1">
                          {interaction.userActionTaken === "Copied to clipboard" && (
                            <Clipboard className="h-4 w-4 text-blue-500" />
                          )}
                          {interaction.userActionTaken === "Edited" && <Edit className="h-4 w-4 text-yellow-500" />}
                          {interaction.userActionTaken === "Discarded" && <Trash2 className="h-4 w-4 text-red-500" />}
                          <span>{interaction.userActionTaken}</span>
                        </div>
                      </div>
                    </>
                  )}
                  {interaction.suggestedReply && (
                    <>
                      <Separator />
                      <div className="space-y-2">
                        <h4 className="font-medium leading-none">Suggested Reply</h4>
                        <p className="text-sm text-muted-foreground">{interaction.suggestedReply}</p>
                      </div>
                    </>
                  )}
                </div>
              </CardContent>
            )}
            <div className="flex items-center justify-between border-t p-4">
              <div className="flex items-center gap-2 text-sm">
                <Clock className="h-4 w-4 text-muted-foreground" />
                <span className="text-muted-foreground">{format(interaction.timestamp, "MMM d, yyyy")}</span>
                <Separator orientation="vertical" className="h-4" />
                <span
                  className={cn(
                    "flex items-center gap-1",
                    interaction.status === "pending" ? "text-yellow-500" : "text-green-500",
                  )}
                >
                  {interaction.status === "pending" ? (
                    <Clock className="h-4 w-4" />
                  ) : (
                    <CheckCircle2 className="h-4 w-4" />
                  )}
                  {interaction.status === "pending" ? "Pending" : "Completed"}
                </span>
              </div>
              <Button
                variant="ghost"
                size="sm"
                onClick={() => setSelectedInteraction(selectedInteraction === interaction.id ? null : interaction.id)}
              >
                {selectedInteraction === interaction.id ? "Hide" : "Review"}
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
            </div>
          </Card>
        ))}
      </div>
    </div>
  )
}

const interactions = [
  {
    id: "1",
    timestamp: new Date("2024-01-28T12:57:00"),
    subject: "Award Documentation Query",
    message:
      "I am reaching out to try to figure out what else I need completed in order to receive my award. I called the office yesterday.",
    status: "pending",
    auditTrail: [
      "Interpreted the request",
      "Suggested the student wait for a Banner update",
      "Reviewed required documentation needed",
      "Reviewed Federal Guidelines",
      "Reviewed University Comms Guidelines",
      "Suggested Reply",
    ],
    userActionTaken: null,
    suggestedReply:
      "Hello Nancy,\n\nThank you for checking in. I reviewed your information and it appears that we need you to fill out the 2024 Family Wealth Disclosure Form (link attached). Once this form is completed and submitted, we will be able to certify your loan and move it forward. Please let me know if you have any trouble filling out the form and I can help with instructions.\n\nI appreciate you reaching out.",
  },
  {
    id: "2",
    timestamp: new Date("2024-01-28T11:30:00"),
    subject: "Loan Processing Concern",
    message: "My loan isn't showing up and I am worried about not getting to the deadline in time",
    status: "completed",
    auditTrail: ["Verified loan status", "Checked processing timeline", "Reviewed deadlines", "Sent status update"],
    userActionTaken: "Copied to clipboard",
    suggestedReply: null,
  },
  {
    id: "3",
    timestamp: new Date("2024-01-28T10:15:00"),
    subject: "Scholarship Application Status",
    message:
      "I submitted my scholarship application last week. Can you tell me when I'll hear back about the decision?",
    status: "completed",
    auditTrail: [
      "Checked scholarship application status",
      "Reviewed decision timeline",
      "Prepared response with estimated timeframe",
    ],
    userActionTaken: "Edited",
    suggestedReply: null,
  },
  {
    id: "4",
    timestamp: new Date("2024-01-28T09:45:00"),
    subject: "FAFSA Verification Process",
    message: "I received an email saying I need to complete verification for my FAFSA. What steps do I need to take?",
    status: "pending",
    auditTrail: ["Reviewing FAFSA status", "Checking verification requirements", "Drafting step-by-step instructions"],
    userActionTaken: null,
    suggestedReply:
      "Dear Student,\n\nI'm currently reviewing the specific verification requirements for your FAFSA. I'll provide you with a detailed list of steps and any necessary forms shortly.\n\nThank you for your patience.",
  },
]

function cn(...classes: string[]) {
  return classes.filter(Boolean).join(" ")
}

