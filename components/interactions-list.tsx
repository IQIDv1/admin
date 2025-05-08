// "use client";

// import { useState } from "react";
// import { format } from "date-fns";
// import {
//   ArrowRight,
//   CheckCircle2,
//   Clock,
//   Filter,
//   MoreVertical,
//   Search,
//   Clipboard,
//   Edit,
//   Trash2,
// } from "lucide-react";
// import { Button } from "@/components/ui/button";
// import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
// import {
//   DropdownMenu,
//   DropdownMenuContent,
//   DropdownMenuItem,
//   DropdownMenuTrigger,
// } from "@/components/ui/dropdown-menu";
// import { Input } from "@/components/ui/input";
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from "@/components/ui/select";
// import { Separator } from "@/components/ui/separator";

// export default function InteractionsList() {
//   const [selectedInteraction, setSelectedInteraction] = useState<string | null>(
//     null
//   );

//   return (
//     <div className="space-y-6">
//       <div className="flex items-center justify-between">
//         <div className="space-y-1">
//           <h2 className="text-2xl font-semibold tracking-tight text-primary">
//             Interactions
//           </h2>
//           <p className="text-sm text-muted-foreground">
//             Review and manage recent student interactions
//           </p>
//         </div>
//         <div className="flex items-center gap-2">
//           <Button variant="outline" size="sm">
//             <Filter className="mr-2 h-4 w-4" />
//             Filter
//           </Button>
//           <Select defaultValue="all">
//             <SelectTrigger className="w-[180px]">
//               <SelectValue placeholder="Status" />
//             </SelectTrigger>
//             <SelectContent>
//               <SelectItem value="all">All Interactions</SelectItem>
//               <SelectItem value="pending">Pending</SelectItem>
//               <SelectItem value="completed">Completed</SelectItem>
//             </SelectContent>
//           </Select>
//           <div className="relative">
//             <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
//             <Input
//               type="search"
//               placeholder="Search interactions..."
//               className="w-[200px] pl-8"
//             />
//           </div>
//         </div>
//       </div>
//       <div className="grid gap-4">
//         {interactions.map((interaction) => (
//           <Card key={interaction.id}>
//             <CardHeader className="p-4">
//               <div className="flex items-start justify-between">
//                 <div className="space-y-1.5">
//                   <CardTitle className="text-base">
//                     <span className="font-mono text-sm font-normal text-muted-foreground">
//                       {format(interaction.timestamp, "HH:mm")}
//                     </span>{" "}
//                     - {interaction.subject}
//                   </CardTitle>
//                   <p className="text-sm text-muted-foreground line-clamp-2">
//                     {interaction.message}
//                   </p>
//                 </div>
//                 <DropdownMenu>
//                   <DropdownMenuTrigger asChild>
//                     <Button variant="ghost" size="sm" className="h-8 w-8 p-0">
//                       <MoreVertical className="h-4 w-4" />
//                     </Button>
//                   </DropdownMenuTrigger>
//                   <DropdownMenuContent align="end">
//                     <DropdownMenuItem>View full history</DropdownMenuItem>
//                     <DropdownMenuItem>Export conversation</DropdownMenuItem>
//                   </DropdownMenuContent>
//                 </DropdownMenu>
//               </div>
//             </CardHeader>
//             {selectedInteraction === interaction.id && (
//               <CardContent className="border-t bg-muted/50 px-4 py-3">
//                 <div className="space-y-4">
//                   <div className="space-y-2">
//                     <h4 className="font-medium leading-none">Audit Trail</h4>
//                     <div className="text-sm text-muted-foreground">
//                       {interaction.auditTrail.map((action, i) => (
//                         <div key={i} className="flex items-center gap-2 py-1">
//                           <CheckCircle2 className="h-4 w-4 text-green-500" />
//                           <span>{action}</span>
//                         </div>
//                       ))}
//                     </div>
//                   </div>
//                   {interaction.userActionTaken && (
//                     <>
//                       <Separator />
//                       <div className="space-y-2">
//                         <h4 className="font-medium leading-none">
//                           User Action Taken
//                         </h4>
//                         <div className="flex items-center gap-2 py-1">
//                           {interaction.userActionTaken ===
//                             "Copied to clipboard" && (
//                             <Clipboard className="h-4 w-4 text-blue-500" />
//                           )}
//                           {interaction.userActionTaken === "Edited" && (
//                             <Edit className="h-4 w-4 text-yellow-500" />
//                           )}
//                           {interaction.userActionTaken === "Discarded" && (
//                             <Trash2 className="h-4 w-4 text-red-500" />
//                           )}
//                           <span>{interaction.userActionTaken}</span>
//                         </div>
//                       </div>
//                     </>
//                   )}
//                   {interaction.suggestedReply && (
//                     <>
//                       <Separator />
//                       <div className="space-y-2">
//                         <h4 className="font-medium leading-none">
//                           Suggested Reply
//                         </h4>
//                         <p className="text-sm text-muted-foreground">
//                           {interaction.suggestedReply}
//                         </p>
//                       </div>
//                     </>
//                   )}
//                 </div>
//               </CardContent>
//             )}
//             <div className="flex items-center justify-between border-t p-4">
//               <div className="flex items-center gap-2 text-sm">
//                 <Clock className="h-4 w-4 text-muted-foreground" />
//                 <span className="text-muted-foreground">
//                   {format(interaction.timestamp, "MMM d, yyyy")}
//                 </span>
//                 <Separator orientation="vertical" className="h-4" />
//                 <span
//                   className={cn(
//                     "flex items-center gap-1",
//                     interaction.status === "pending"
//                       ? "text-yellow-500"
//                       : "text-green-500"
//                   )}
//                 >
//                   {interaction.status === "pending" ? (
//                     <Clock className="h-4 w-4" />
//                   ) : (
//                     <CheckCircle2 className="h-4 w-4" />
//                   )}
//                   {interaction.status === "pending" ? "Pending" : "Completed"}
//                 </span>
//               </div>
//               <Button
//                 variant="ghost"
//                 size="sm"
//                 onClick={() =>
//                   setSelectedInteraction(
//                     selectedInteraction === interaction.id
//                       ? null
//                       : interaction.id
//                   )
//                 }
//               >
//                 {selectedInteraction === interaction.id ? "Hide" : "Review"}
//                 <ArrowRight className="ml-2 h-4 w-4" />
//               </Button>
//             </div>
//           </Card>
//         ))}
//       </div>
//     </div>
//   );
// }

// const interactions = [
//   {
//     id: "1",
//     timestamp: new Date("2024-01-28T12:57:00"),
//     subject: "Award Documentation Query",
//     message:
//       "I am reaching out to try to figure out what else I need completed in order to receive my award. I called the office yesterday.",
//     status: "pending",
//     auditTrail: [
//       "Interpreted the request",
//       "Suggested the student wait for a Banner update",
//       "Reviewed required documentation needed",
//       "Reviewed Federal Guidelines",
//       "Reviewed University Comms Guidelines",
//       "Suggested Reply",
//     ],
//     userActionTaken: null,
//     suggestedReply:
//       "Hello Nancy,\n\nThank you for checking in. I reviewed your information and it appears that we need you to fill out the 2024 Family Wealth Disclosure Form (link attached). Once this form is completed and submitted, we will be able to certify your loan and move it forward. Please let me know if you have any trouble filling out the form and I can help with instructions.\n\nI appreciate you reaching out.",
//   },
//   {
//     id: "2",
//     timestamp: new Date("2024-01-28T11:30:00"),
//     subject: "Loan Processing Concern",
//     message:
//       "My loan isn't showing up and I am worried about not getting to the deadline in time",
//     status: "completed",
//     auditTrail: [
//       "Verified loan status",
//       "Checked processing timeline",
//       "Reviewed deadlines",
//       "Sent status update",
//     ],
//     userActionTaken: "Copied to clipboard",
//     suggestedReply: null,
//   },
//   {
//     id: "3",
//     timestamp: new Date("2024-01-28T10:15:00"),
//     subject: "Scholarship Application Status",
//     message:
//       "I submitted my scholarship application last week. Can you tell me when I'll hear back about the decision?",
//     status: "completed",
//     auditTrail: [
//       "Checked scholarship application status",
//       "Reviewed decision timeline",
//       "Prepared response with estimated timeframe",
//     ],
//     userActionTaken: "Edited",
//     suggestedReply: null,
//   },
//   {
//     id: "4",
//     timestamp: new Date("2024-01-28T09:45:00"),
//     subject: "FAFSA Verification Process",
//     message:
//       "I received an email saying I need to complete verification for my FAFSA. What steps do I need to take?",
//     status: "pending",
//     auditTrail: [
//       "Reviewing FAFSA status",
//       "Checking verification requirements",
//       "Drafting step-by-step instructions",
//     ],
//     userActionTaken: null,
//     suggestedReply:
//       "Dear Student,\n\nI'm currently reviewing the specific verification requirements for your FAFSA. I'll provide you with a detailed list of steps and any necessary forms shortly.\n\nThank you for your patience.",
//   },
// ];

// function cn(...classes: string[]) {
//   return classes.filter(Boolean).join(" ");
// }

"use client";

import { useState, useEffect } from "react";
import { format, isWithinInterval, parse } from "date-fns";
import {
  ArrowRight,
  CheckCircle2,
  Clock,
  MoreVertical,
  Search,
  Clipboard,
  Edit,
  Trash2,
  Calendar,
  ChevronDown,
  X,
  History,
  Send,
  Pen,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Separator } from "@/components/ui/separator";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Textarea } from "@/components/ui/textarea";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";

export default function InteractionsList() {
  const [selectedInteraction, setSelectedInteraction] = useState<string | null>(
    null
  );
  const [isFilterOpen, setIsFilterOpen] = useState(false);
  const [isFullScreenMode, setIsFullScreenMode] = useState(false);
  const [activeTab, setActiveTab] = useState("detected");
  const [draftResponse, setDraftResponse] = useState("");

  // Date range state
  const [startMonth, setStartMonth] = useState<string>("");
  const [startDay, setStartDay] = useState<string>("");
  const [startYear, setStartYear] = useState<string>("");
  const [endMonth, setEndMonth] = useState<string>("");
  const [endDay, setEndDay] = useState<string>("");
  const [endYear, setEndYear] = useState<string>("");

  // Derived state for the actual date objects
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [endDate, setEndDate] = useState<Date | null>(null);

  // Update the actual date objects when the individual components change
  useEffect(() => {
    if (startYear && startMonth && startDay) {
      try {
        const dateStr = `${startYear}-${startMonth}-${startDay}`;
        const date = parse(dateStr, "yyyy-MM-dd", new Date());
        setStartDate(date);
      } catch (e) {
        setStartDate(null);
      }
    } else {
      setStartDate(null);
    }
  }, [startYear, startMonth, startDay]);

  useEffect(() => {
    if (endYear && endMonth && endDay) {
      try {
        const dateStr = `${endYear}-${endMonth}-${endDay}`;
        const date = parse(dateStr, "yyyy-MM-dd", new Date());
        // Set to end of day
        date.setHours(23, 59, 59, 999);
        setEndDate(date);
      } catch (e) {
        setEndDate(null);
      }
    } else {
      setEndDate(null);
    }
  }, [endYear, endMonth, endDay]);

  // Generate arrays for days, months, and years
  const days = Array.from({ length: 31 }, (_, i) =>
    String(i + 1).padStart(2, "0")
  );
  const months = [
    { value: "01", label: "January" },
    { value: "02", label: "February" },
    { value: "03", label: "March" },
    { value: "04", label: "April" },
    { value: "05", label: "May" },
    { value: "06", label: "June" },
    { value: "07", label: "July" },
    { value: "08", label: "August" },
    { value: "09", label: "September" },
    { value: "10", label: "October" },
    { value: "11", label: "November" },
    { value: "12", label: "December" },
  ];
  const currentYear = new Date().getFullYear();
  const years = Array.from({ length: 5 }, (_, i) =>
    String(currentYear - 2 + i)
  );

  // Format the date range for display
  const formatDateRange = () => {
    if (!startDate) return "Filter by Date Range";
    if (!endDate) return `From ${format(startDate, "MMM dd, yyyy")}`;
    return `${format(startDate, "MMM dd, yyyy")} - ${format(
      endDate,
      "MMM dd, yyyy"
    )}`;
  };

  // Clear all date selections
  const clearDateRange = () => {
    setStartMonth("");
    setStartDay("");
    setStartYear("");
    setEndMonth("");
    setEndDay("");
    setEndYear("");
    setStartDate(null);
    setEndDate(null);
    setIsFilterOpen(false);
  };

  // Filter interactions based on date range
  const filteredInteractions = interactions.filter((interaction) => {
    if (!startDate) return true;

    const interactionDate = new Date(interaction.timestamp);

    if (endDate) {
      return isWithinInterval(interactionDate, {
        start: startDate,
        end: endDate,
      });
    }

    // If only start date is selected, match that specific day
    return (
      interactionDate.getDate() === startDate.getDate() &&
      interactionDate.getMonth() === startDate.getMonth() &&
      interactionDate.getFullYear() === startDate.getFullYear()
    );
  });

  // Get the selected interaction data
  const selectedInteractionData = selectedInteraction
    ? interactions.find((i) => i.id === selectedInteraction)
    : null;

  // Set default draft response when an interaction is selected
  useEffect(() => {
    if (selectedInteractionData) {
      setDraftResponse(`Dear ${selectedInteractionData.studentName},

Thank you for reaching out regarding your financial aid concerns. I understand your worry about submitting your FAFSA late and its potential impact on your aid package. Let me provide you with some specific information based on your current status:

1. Your FAFSA was submitted on 11/15/2023, which is after our priority deadline but still within the acceptable timeframe for aid consideration.

2. Current Aid Status:
   - Federal Pell Grant: $3,172
   - Federal Direct Subsidized Loan: $3,500
   - Federal Direct Unsubsidized Loan: $2,000

3. Next Steps:
   - <a style="color: blue;" href="https://example.com/schedule-appointment">Schedule an appointment</a> with our financial aid counselor, Ms. Thompson, to discuss your specific situation in detail.
   - Attend our upcoming workshop on "Maximizing Your Financial Aid" on 12/05/2023. <a style="color: blue;" href="https://example.com/workshop-registration">Register here</a>.

Please don't hesitate to reach out if you have any questions. We're here to help you navigate this process and ensure you have the support you need to continue your education.

Best regards,
John Doe
Financial Aid Advisor
State University`);
    } else {
      setDraftResponse("");
    }
  }, [selectedInteractionData]);

  // Handle review click
  const handleReviewClick = (interactionId: string) => {
    setSelectedInteraction(interactionId);
    setIsFullScreenMode(true);
  };

  // Handle exit full screen
  const handleExitFullScreen = () => {
    setIsFullScreenMode(false);
  };

  // If in full screen mode, show the detailed view
  if (isFullScreenMode && selectedInteractionData) {
    return (
      <div className="fixed inset-0 z-50 bg-background">
        {/* <div className="fixed inset-0 z-50 bg-background" style={{ left: "20%" }}> */}

        <div className="flex h-full flex-col">
          <header className="flex h-[52px] items-center justify-between border-b px-6">
            <div className="flex items-center gap-2">
              <h1 className="text-xl font-semibold text-primary">
                Write Email
              </h1>
            </div>
            <Button variant="ghost" size="icon" onClick={handleExitFullScreen}>
              <X className="h-5 w-5" />
            </Button>
          </header>

          <div className="flex flex-1 overflow-hidden">
            <div className="flex-1 overflow-auto p-6">
              <Tabs
                value={activeTab}
                onValueChange={setActiveTab}
                className="w-full"
              >
                <div className="flex justify-between items-center mb-4">
                  <TabsList>
                    <TabsTrigger value="detected">Detected</TabsTrigger>
                    <TabsTrigger value="paste">Paste an Email</TabsTrigger>
                  </TabsList>
                  <Button variant="outline" className="text-primary">
                    <History className="mr-2 h-4 w-4" />
                    Show History
                  </Button>
                </div>

                <TabsContent value="detected" className="space-y-4">
                  <div className="space-y-2">
                    <h3 className="text-lg font-medium">Detected Email:</h3>
                    <Textarea
                      className="min-h-[200px]"
                      readOnly
                      value={`Dear Financial Aid Office,

I'm worried about my financial aid package for next semester. I submitted my FAFSA late and I'm not sure if I'll receive enough aid to cover my tuition. Can you please help me understand my options?

Thank you,
${selectedInteractionData.studentName}
Student ID: ${selectedInteractionData.studentId}`}
                    />
                  </div>

                  <div className="space-y-2">
                    <h3 className="text-lg font-medium">Draft Response:</h3>
                    <Textarea
                      className="min-h-[300px]"
                      value={draftResponse}
                      onChange={(e) => setDraftResponse(e.target.value)}
                    />
                  </div>

                  <div className="flex justify-end gap-2">
                    <Button variant="outline">
                      <Pen className="mr-2 h-4 w-4" />
                      Clear
                    </Button>
                    <Button className="bg-purple hover:bg-purple-dark">
                      <Send className="mr-2 h-4 w-4" />
                      Send
                    </Button>
                  </div>
                </TabsContent>

                <TabsContent value="paste" className="space-y-4">
                  <div className="space-y-2">
                    <h3 className="text-lg font-medium">Paste an Email:</h3>
                    <Textarea
                      className="min-h-[200px]"
                      placeholder="Paste the email content here..."
                    />
                  </div>
                </TabsContent>
              </Tabs>
            </div>

            <div className="w-[350px] border-l p-6 overflow-y-auto">
              <div className="space-y-6">
                <div>
                  <h3 className="text-lg font-semibold mb-4">
                    Student Information
                  </h3>

                  <div className="space-y-4">
                    <div>
                      <h4 className="font-medium">Name:</h4>
                      <p>{selectedInteractionData.studentName}</p>
                    </div>

                    <div>
                      <h4 className="font-medium">Student ID:</h4>
                      <p>{selectedInteractionData.studentId}</p>
                    </div>

                    <div>
                      <h4 className="font-medium">FAFSA Submission Date:</h4>
                      <p>11/15/2023</p>
                    </div>

                    <div>
                      <h4 className="font-medium">Cost of Attendance (COA):</h4>
                      <p>$25,000</p>
                    </div>

                    <div>
                      <h4 className="font-medium">Award Status:</h4>
                      <p>Not Accepted</p>
                    </div>

                    <div>
                      <h4 className="font-medium">Enrollment Status:</h4>
                      <p>Full-time</p>
                    </div>

                    <div>
                      <h4 className="font-medium">Current Aid Status:</h4>
                      <ul className="list-disc pl-5 space-y-1">
                        <li>Federal Pell Grant: $3,172</li>
                        <li>Federal Direct Subsidized Loan: $3,500</li>
                        <li>Federal Direct Unsubsidized Loan: $2,000</li>
                      </ul>
                    </div>

                    <div>
                      <h4 className="font-medium">Outstanding Requirements:</h4>
                      <ul className="list-disc pl-5 space-y-1">
                        <li>Signed copy of 2023 tax return</li>
                        <li>Verification worksheet</li>
                      </ul>
                    </div>
                  </div>
                </div>

                <Separator />

                <div>
                  <h3 className="text-lg font-semibold mb-4">Context</h3>

                  <div className="space-y-4">
                    <div className="bg-slate-50 p-4 rounded-md">
                      <h4 className="font-medium text-primary">Banner (SIS)</h4>
                      <p className="text-sm mb-2">
                        Student enrollment status, financial aid package
                        details, and outstanding requirements
                      </p>
                      <Button
                        variant="link"
                        className="text-blue-500 p-0 h-auto"
                      >
                        View Data
                      </Button>
                    </div>

                    <div className="bg-slate-50 p-4 rounded-md">
                      <h4 className="font-medium text-primary">EDConnect</h4>
                      <p className="text-sm mb-2">
                        FAFSA submission date, EFC, and verification status
                      </p>
                      <Button
                        variant="link"
                        className="text-blue-500 p-0 h-auto"
                      >
                        View Data
                      </Button>
                    </div>

                    <div className="bg-slate-50 p-4 rounded-md">
                      <h4 className="font-medium text-primary">
                        PeopleSoft API
                      </h4>
                      <p className="text-sm mb-2">
                        Student account balance and financial aid status
                      </p>
                      <Button
                        variant="link"
                        className="text-blue-500 p-0 h-auto"
                      >
                        View Data
                      </Button>
                    </div>

                    <div className="bg-slate-50 p-4 rounded-md">
                      <h4 className="font-medium text-primary">Outlook API</h4>
                      <p className="text-sm mb-2">
                        Recent email communications with the student
                      </p>
                      <Button
                        variant="link"
                        className="text-blue-500 p-0 h-auto"
                      >
                        View Data
                      </Button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Regular list view
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div className="space-y-1">
          <h2 className="text-2xl font-semibold tracking-tight">
            Interactions
          </h2>
          <p className="text-sm text-muted-foreground">
            Review and manage recent student interactions
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            className="text-primary hover:bg-purple hover:text-white flex items-center gap-2"
            onClick={() => setIsFilterOpen(true)}
          >
            <Calendar className="h-4 w-4" />
            {formatDateRange()}
            <ChevronDown className="h-3 w-3 opacity-50" />
          </Button>

          <Dialog open={isFilterOpen} onOpenChange={setIsFilterOpen}>
            <DialogContent className="sm:max-w-[425px]">
              <DialogHeader>
                <DialogTitle className="text-primary">
                  Select Date Range
                </DialogTitle>
                <DialogDescription>
                  Choose start and end dates to filter interactions
                </DialogDescription>
              </DialogHeader>

              <div className="space-y-4 py-4">
                <div>
                  <h4 className="text-sm font-medium mb-2">Start Date</h4>
                  <div className="grid grid-cols-3 gap-2">
                    <Select value={startMonth} onValueChange={setStartMonth}>
                      <SelectTrigger>
                        <SelectValue placeholder="Month" />
                      </SelectTrigger>
                      <SelectContent>
                        {months.map((month) => (
                          <SelectItem key={month.value} value={month.value}>
                            {month.label}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>

                    <Select value={startDay} onValueChange={setStartDay}>
                      <SelectTrigger>
                        <SelectValue placeholder="Day" />
                      </SelectTrigger>
                      <SelectContent>
                        {days.map((day) => (
                          <SelectItem key={day} value={day}>
                            {day}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>

                    <Select value={startYear} onValueChange={setStartYear}>
                      <SelectTrigger>
                        <SelectValue placeholder="Year" />
                      </SelectTrigger>
                      <SelectContent>
                        {years.map((year) => (
                          <SelectItem key={year} value={year}>
                            {year}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                </div>

                <div>
                  <h4 className="text-sm font-medium mb-2">End Date</h4>
                  <div className="grid grid-cols-3 gap-2">
                    <Select value={endMonth} onValueChange={setEndMonth}>
                      <SelectTrigger>
                        <SelectValue placeholder="Month" />
                      </SelectTrigger>
                      <SelectContent>
                        {months.map((month) => (
                          <SelectItem key={month.value} value={month.value}>
                            {month.label}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>

                    <Select value={endDay} onValueChange={setEndDay}>
                      <SelectTrigger>
                        <SelectValue placeholder="Day" />
                      </SelectTrigger>
                      <SelectContent>
                        {days.map((day) => (
                          <SelectItem key={day} value={day}>
                            {day}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>

                    <Select value={endYear} onValueChange={setEndYear}>
                      <SelectTrigger>
                        <SelectValue placeholder="Year" />
                      </SelectTrigger>
                      <SelectContent>
                        {years.map((year) => (
                          <SelectItem key={year} value={year}>
                            {year}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              </div>

              <DialogFooter>
                <Button
                  variant="outline"
                  onClick={clearDateRange}
                  className="text-primary hover:bg-purple/10"
                >
                  Clear
                </Button>
                <Button
                  variant="default"
                  onClick={() => setIsFilterOpen(false)}
                  className="bg-purple hover:bg-purple-dark text-white"
                  disabled={!startDate}
                >
                  Apply Filter
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>

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
            <Input
              type="search"
              placeholder="Search interactions..."
              className="w-[200px] pl-8"
            />
          </div>
        </div>
      </div>
      <div className="grid gap-4">
        {filteredInteractions.length > 0 ? (
          filteredInteractions.map((interaction) => (
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
                    <p className="text-sm text-muted-foreground line-clamp-2">
                      {interaction.message}
                    </p>
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
              {selectedInteraction === interaction.id && !isFullScreenMode && (
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
                          <h4 className="font-medium leading-none">
                            User Action Taken
                          </h4>
                          <div className="flex items-center gap-2 py-1">
                            {interaction.userActionTaken ===
                              "Copied to clipboard" && (
                              <Clipboard className="h-4 w-4 text-blue-500" />
                            )}
                            {interaction.userActionTaken === "Edited" && (
                              <Edit className="h-4 w-4 text-yellow-500" />
                            )}
                            {interaction.userActionTaken === "Discarded" && (
                              <Trash2 className="h-4 w-4 text-red-500" />
                            )}
                            <span>{interaction.userActionTaken}</span>
                          </div>
                        </div>
                      </>
                    )}
                    {interaction.suggestedReply && (
                      <>
                        <Separator />
                        <div className="space-y-2">
                          <h4 className="font-medium leading-none">
                            Suggested Reply
                          </h4>
                          <p className="text-sm text-muted-foreground">
                            {interaction.suggestedReply}
                          </p>
                        </div>
                      </>
                    )}
                  </div>
                </CardContent>
              )}
              <div className="flex items-center justify-between border-t p-4">
                <div className="flex items-center gap-2 text-sm">
                  <Clock className="h-4 w-4 text-muted-foreground" />
                  <span className="text-muted-foreground">
                    {format(interaction.timestamp, "MMM d, yyyy")}
                  </span>
                  <Separator orientation="vertical" className="h-4" />
                  <span
                    className={cn(
                      "flex items-center gap-1",
                      interaction.status === "pending"
                        ? "text-yellow-500"
                        : "text-green-500"
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
                  onClick={() => handleReviewClick(interaction.id)}
                  className="text-primary"
                >
                  Review
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              </div>
            </Card>
          ))
        ) : (
          <div className="flex flex-col items-center justify-center py-10 text-center">
            <Calendar className="h-10 w-10 text-primary mb-2" />
            <h3 className="text-lg font-medium">No interactions found</h3>
            <p className="text-sm text-muted-foreground mt-1">
              {startDate && endDate ? (
                <>
                  No interactions found between{" "}
                  {format(startDate, "MMMM dd, yyyy")} and{" "}
                  {format(endDate, "MMMM dd, yyyy")}
                </>
              ) : startDate ? (
                <>
                  No interactions found for {format(startDate, "MMMM dd, yyyy")}
                </>
              ) : (
                "No interactions match your filters"
              )}
            </p>
            <Button
              variant="outline"
              size="sm"
              onClick={clearDateRange}
              className="mt-4 text-primary hover:bg-purple hover:text-white"
            >
              Clear Filter
            </Button>
          </div>
        )}
      </div>
    </div>
  );
}

// Updated interactions data with student information
const interactions = [
  {
    id: "1",
    timestamp: new Date("2024-01-28T12:57:00"),
    subject: "Award Documentation Query",
    message:
      "I am reaching out to try to figure out what else I need completed in order to receive my award. I called the office yesterday.",
    status: "pending",
    studentName: "Sarah Johnson",
    studentId: "123456",
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
      "Hello Sarah,\n\nThank you for checking in. I reviewed your information and it appears that we need you to fill out the 2024 Family Wealth Disclosure Form (link attached). Once this form is completed and submitted, we will be able to certify your loan and move it forward. Please let me know if you have any trouble filling out the form and I can help with instructions.\n\nI appreciate you reaching out.",
  },
  {
    id: "2",
    timestamp: new Date("2024-01-28T11:30:00"),
    subject: "Loan Processing Concern",
    message:
      "My loan isn't showing up and I am worried about not getting to the deadline in time",
    status: "completed",
    studentName: "Michael Brown",
    studentId: "234567",
    auditTrail: [
      "Verified loan status",
      "Checked processing timeline",
      "Reviewed deadlines",
      "Sent status update",
    ],
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
    studentName: "Emily Davis",
    studentId: "345678",
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
    timestamp: new Date("2024-01-27T09:45:00"),
    subject: "FAFSA Verification Process",
    message:
      "I received an email saying I need to complete verification for my FAFSA. What steps do I need to take?",
    status: "pending",
    studentName: "David Wilson",
    studentId: "456789",
    auditTrail: [
      "Reviewing FAFSA status",
      "Checking verification requirements",
      "Drafting step-by-step instructions",
    ],
    userActionTaken: null,
    suggestedReply:
      "Dear David,\n\nI'm currently reviewing the specific verification requirements for your FAFSA. I'll provide you with a detailed list of steps and any necessary forms shortly.\n\nThank you for your patience.",
  },
  {
    id: "5",
    timestamp: new Date("2024-01-25T14:20:00"),
    subject: "Financial Aid Appeal",
    message:
      "I need to appeal my financial aid decision due to changes in my family's financial situation.",
    status: "completed",
    studentName: "Jessica Martinez",
    studentId: "567890",
    auditTrail: [
      "Reviewed appeal process",
      "Checked required documentation",
      "Provided appeal form",
    ],
    userActionTaken: "Copied to clipboard",
    suggestedReply: null,
  },
  {
    id: "6",
    timestamp: new Date("2024-01-23T09:15:00"),
    subject: "Work Study Eligibility",
    message:
      "I'm wondering if I'm eligible for work study this semester based on my financial aid package.",
    status: "completed",
    studentName: "Ryan Taylor",
    studentId: "678901",
    auditTrail: [
      "Checked eligibility criteria",
      "Reviewed student's package",
      "Provided eligibility information",
    ],
    userActionTaken: "Edited",
    suggestedReply: null,
  },
];

function cn(...classes: string[]) {
  return classes.filter(Boolean).join(" ");
}
