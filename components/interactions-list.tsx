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
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { MessageDetails } from "@/components/messages/details";
import { createClient } from "@/lib/supabase/client";
import { getOrganizationInboundMessages } from "@/lib/supabase/queries";
import { cn } from "@/lib/utils";
import type { Member } from "@/lib/types";

// Local Interaction type for component state
type Interaction = {
  id: string;
  body: string | null;
  receivedAt: Date;
  senderAddress: string;
  subject: string;
  studentName: string;
  studentId: string;
  auditTrail: string[];
  status: "pending" | "completed";
  userActionTaken: string | null;
  suggestedReply: string | null;
};

export default function InteractionsList({ currentUser }: { currentUser: Member }) {
  // State to hold fetched interactions
  const [interactions, setInteractions] = useState<Interaction[]>([]);
  const [selectedInteraction, setSelectedInteraction] = useState<string | null>(
    null
  );
  const [isFilterOpen, setIsFilterOpen] = useState(false);
  const [isFullScreenMode, setIsFullScreenMode] = useState(false);

  // Fetch interactions on component mount
  useEffect(() => {
    async function fetchInteractions() {
      const supabase = createClient();
      try {
        const data = await getOrganizationInboundMessages(
          supabase,
          currentUser.organization_id
        );
        const formatted: Interaction[] = data.map((msg) => {
          const firstStudent = msg.students[0]?.student;
          return {
            id: msg.id,
            body: msg.body,
            receivedAt: new Date(msg.received_at),
            senderAddress: msg.sender_address,
            subject: msg.subject ?? "",
            studentName: firstStudent
              ? `${firstStudent.first_name} ${firstStudent.last_name}`
              : "(unknown)",
            studentId: firstStudent?.id ?? "",
            auditTrail: [],
            status: "pending",
            userActionTaken: null,
            suggestedReply: null,
          };
        });
        setInteractions(formatted);
      } catch (error) {
        console.error("Error fetching interactions:", error);
      }
    }
    fetchInteractions();
  }, [currentUser.organization_id]);

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
      } catch {
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
      } catch {
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

    const interactionDate = interaction.receivedAt;

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
      <MessageDetails
        message={selectedInteractionData}
        onClose={handleExitFullScreen}
      />
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
                      <div className="flex items-center gap-6 w-full">
                        <span
                          className="truncate text-primary w-36 block"
                          title={interaction.studentId ? interaction.studentName : interaction.senderAddress}
                        >
                          {interaction.studentId
                            ? interaction.studentName
                            : interaction.senderAddress}
                        </span>
                        <span
                          className="truncate w-64 block"
                          title={interaction.subject}
                        >
                          {interaction.subject}
                        </span>
                      </div>
                    </CardTitle>
                    <p className="text-sm text-muted-foreground line-clamp-2">
                      {interaction.body}
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
                <div className="flex items-center gap-3 text-sm">
                  <Clock className="h-4 w-4 text-muted-foreground" />
                  <span className="text-muted-foreground">
                    {format(interaction.receivedAt, "MMM d, yyyy")}{" "}
                    {format(interaction.receivedAt, "h:mm a").toUpperCase()}
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
