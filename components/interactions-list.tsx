'use client';

import { useState, useEffect, useCallback } from 'react';
import { format, isWithinInterval, parse } from 'date-fns';
import {
  ArrowRight,
  Calendar,
  CheckCircle2,
  ChevronDown,
  Clipboard,
  Clock,
  MoreVertical,
  Search,
  SkipForward,
  SquarePen,
  Trash2
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from '@/components/ui/select';
import { Separator } from '@/components/ui/separator';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter
} from '@/components/ui/dialog';
import { MessageDetails } from '@/components/messages/details';
import { createClient } from '@/lib/supabase/client';
import {
  getOrganizationInboundMessages,
  type OutboundMessageVersionSummary
} from '@/lib/supabase/queries';
import { cn } from '@/lib/utils';
import type { Member } from '@/lib/types';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger
} from '@/components/ui/accordion';

// Local Interaction type for component state
type Interaction = {
  id: string;
  body: string | null;
  receivedAt: Date;
  senderAddress: string;
  subject: string;
  studentName: string;
  studentId: string;
  auditTrail: {
    inbound: { action: string; actionData: unknown }[];
    outbound?: { action: string; actionData: unknown }[];
  };
  status: 'skipped' | 'pending' | 'completed';
  suggestedReply: OutboundMessageVersionSummary | null;
};

const INBOUND_ACTION_DISPLAY: Record<string, string> = {
  interpreted_request: 'Interpreted the Request',
  skipped_evaluation: 'Skipped Evaluation',
  summarized_question: 'Provided Email Summary',
  suggested_next_questions: 'Anticipated Follow-up Questions',
  suggested_next_actions: 'Suggested Follow-up Actions'
};

const OUTBOUND_ACTION_DISPLAY: Record<string, string> = {
  copied: 'Copied to Clipboard',
  discarded: 'Discarded Message',
  edited: 'Edited Message',
  sent: 'Sent Message'
};

const UserActionIcon = ({ action }: { action: string }) => {
  switch (action) {
    case 'copied':
      return <Clipboard className="h-4 w-4 text-blue-500" />;
    case 'discarded':
      return <Trash2 className="h-4 w-4 text-red-500" />;
    case 'edited':
      return <SquarePen className="h-4 w-4 text-yellow-500" />;
    default:
      return <CheckCircle2 className="h-4 w-4 text-green-500" />;
  }
};

const UserActionsTaken = ({ interaction }: { interaction: Interaction }) => {
  const renderActionData = (data: unknown): React.ReactNode => {
    if (typeof data === 'object' && data !== null && !Array.isArray(data)) {
      return (
        <ul className="list-disc pl-5 space-y-1 p-2 text-sm">
          {Object.entries(data).map(([key, value]) => (
            <li key={key}>
              {`${key}: ${typeof value === 'string' ? value : JSON.stringify(value)}`}
            </li>
          ))}
        </ul>
      );
    } else if (typeof data === 'string') {
      return <p className="px-1 py-2 text-sm">{data}</p>;
    } else if (Array.isArray(data)) {
      return (
        <ul className="list-disc pl-5 space-y-1 p-2 text-sm">
          {data.map((item, index) => (
            <li key={index}>{JSON.stringify(item)}</li>
          ))}
        </ul>
      );
    }
    return <pre className="p-2 text-sm whitespace-pre-wrap">{JSON.stringify(data, null, 2)}</pre>;
  };

  return (
    <div>
      <h4 className="font-semibold mb-2 mt-0 text-base text-gray-800/80">User Actions Taken</h4>
      <Accordion type="single" collapsible className="space-y-0">
        {interaction.auditTrail.outbound?.map((log, idx) => (
          <AccordionItem className="border-b-0" key={idx} value={`outbound-${idx}`}>
            <AccordionTrigger className="py-1">
              <div className="flex items-center gap-2 text-gray-800/70 text-sm">
                <UserActionIcon action={log.action} />{' '}
                {OUTBOUND_ACTION_DISPLAY[log.action] || log.action}
              </div>
            </AccordionTrigger>
            <AccordionContent className="pb-2 text-gray-800/70">
              {log.actionData != null && renderActionData(log.actionData)}
            </AccordionContent>
          </AccordionItem>
        ))}
      </Accordion>
    </div>
  );
};

const UserActionsTakenWrapper = ({ interaction }: { interaction: Interaction }) => {
  if (
    Array.isArray(interaction.auditTrail.outbound) &&
    interaction.auditTrail.outbound.length > 0
  ) {
    const hasInboundActions =
      Array.isArray(interaction.auditTrail.inbound) && interaction.auditTrail.inbound.length > 0;
    if (hasInboundActions) {
      return (
        <>
          <Separator />
          <UserActionsTaken interaction={interaction} />
        </>
      );
    }
    return <UserActionsTaken interaction={interaction} />;
  }
  return null;
};

const InteractionAuditTrail = ({ interaction }: { interaction: Interaction }) => {
  return (
    <div>
      <h4 className="font-semibold mb-2 mt-0 text-base text-gray-800/80">Audit Trail</h4>
      <Accordion type="single" collapsible className="space-y-0">
        {interaction.auditTrail.inbound.map((log, idx) =>
          log.actionData != null ? (
            <AccordionItem className="border-b-0" key={idx} value={`log-${idx}`}>
              <AccordionTrigger className="py-1">
                <div className="flex font-normal items-center gap-2 leading-normal text-gray-800/70 text-sm">
                  <CheckCircle2 className="h-4 w-4 text-green-500" />
                  {INBOUND_ACTION_DISPLAY[log.action] || log.action}
                </div>
              </AccordionTrigger>
              <AccordionContent className="pb-2 text-gray-800/70">
                {typeof log.actionData === 'string' ? (
                  <p className="px-1 py-2 text-sm">{log.actionData}</p>
                ) : Array.isArray(log.actionData) ? (
                  <ul className="list-disc pl-5 space-y-1 p-2 text-sm">
                    {log.actionData.map((item, i) => (
                      <li key={i}>{item}</li>
                    ))}
                  </ul>
                ) : (
                  <pre className="p-2 text-sm whitespace-pre-wrap">
                    {JSON.stringify(log.actionData, null, 2)}
                  </pre>
                )}
              </AccordionContent>
            </AccordionItem>
          ) : (
            <div key={idx} className="flex flex-1 items-center justify-between py-1">
              <div className="flex items-center gap-2 leading-normal text-gray-800/80 text-sm">
                <CheckCircle2 className="h-4 w-4 text-green-500" />
                {INBOUND_ACTION_DISPLAY[log.action] || log.action}
              </div>
            </div>
          )
        )}
      </Accordion>
    </div>
  );
};

const InteractionAuditTrailWrapper = ({ interaction }: { interaction: Interaction }) => {
  if (Array.isArray(interaction.auditTrail.inbound) && interaction.auditTrail.inbound.length > 0) {
    return <InteractionAuditTrail interaction={interaction} />;
  }
  return null;
};

export default function InteractionsList({ currentUser }: { currentUser: Member }) {
  // State to hold fetched interactions
  const [interactions, setInteractions] = useState<Interaction[]>([]);
  // Track selected interaction and view states
  const [selectedInteraction, setSelectedInteraction] = useState<string | null>(null);
  const [isFilterOpen, setIsFilterOpen] = useState(false);
  const [isFullScreenMode, setIsFullScreenMode] = useState(false);
  // Function to fetch interactions list
  const fetchInteractions = useCallback(async () => {
    const supabase = createClient();
    try {
      const data = await getOrganizationInboundMessages(supabase, currentUser.organization_id);
      const formatted: Interaction[] = data.map((msg) => {
        const firstStudent = msg.students[0]?.student;
        const inbound = (msg.inbound_activities ?? []).map((a) => ({
          action: a.action,
          actionData: a.action_data
        }));
        const outbound = (msg.organization_outbound_message?.outbound_activities ?? []).map(
          (a) => ({ action: a.action, actionData: a.action_data })
        );
        const isMessageSkipped = inbound.some((a) => a.action === 'skipped_evaluation');
        return {
          id: msg.id,
          body: msg.body,
          receivedAt: new Date(msg.received_at),
          senderAddress: msg.sender_address,
          subject: msg.subject ?? '',
          studentName: firstStudent
            ? `${firstStudent.first_name} ${firstStudent.last_name}`
            : '(unknown)',
          studentId: firstStudent?.id ?? '',
          auditTrail: { inbound, outbound },
          status: msg.organization_outbound_message?.latest_version
            ? 'completed'
            : isMessageSkipped
              ? 'skipped'
              : 'pending',
          suggestedReply: msg.organization_outbound_message?.latest_version ?? null
        };
      });
      setInteractions(formatted);
    } catch (error) {
      console.error('Error fetching interactions:', error);
    }
  }, [currentUser.organization_id]);

  // Fetch interactions on component mount
  useEffect(() => {
    fetchInteractions();
  }, [fetchInteractions]);

  // Date range state
  const [startMonth, setStartMonth] = useState<string>('');
  const [startDay, setStartDay] = useState<string>('');
  const [startYear, setStartYear] = useState<string>('');
  const [endMonth, setEndMonth] = useState<string>('');
  const [endDay, setEndDay] = useState<string>('');
  const [endYear, setEndYear] = useState<string>('');

  // Derived state for the actual date objects
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [endDate, setEndDate] = useState<Date | null>(null);

  // Update the actual date objects when the individual components change
  useEffect(() => {
    if (startYear && startMonth && startDay) {
      try {
        const dateStr = `${startYear}-${startMonth}-${startDay}`;
        const date = parse(dateStr, 'yyyy-MM-dd', new Date());
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
        const date = parse(dateStr, 'yyyy-MM-dd', new Date());
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
  const days = Array.from({ length: 31 }, (_, i) => String(i + 1).padStart(2, '0'));
  const months = [
    { value: '01', label: 'January' },
    { value: '02', label: 'February' },
    { value: '03', label: 'March' },
    { value: '04', label: 'April' },
    { value: '05', label: 'May' },
    { value: '06', label: 'June' },
    { value: '07', label: 'July' },
    { value: '08', label: 'August' },
    { value: '09', label: 'September' },
    { value: '10', label: 'October' },
    { value: '11', label: 'November' },
    { value: '12', label: 'December' }
  ];
  const currentYear = new Date().getFullYear();
  const years = Array.from({ length: 5 }, (_, i) => String(currentYear - 2 + i));

  // Format the date range for display
  const formatDateRange = () => {
    if (!startDate) return 'Filter by Date Range';
    if (!endDate) return `From ${format(startDate, 'MMM dd, yyyy')}`;
    return `${format(startDate, 'MMM dd, yyyy')} - ${format(endDate, 'MMM dd, yyyy')}`;
  };

  // Clear all date selections
  const clearDateRange = () => {
    setStartMonth('');
    setStartDay('');
    setStartYear('');
    setEndMonth('');
    setEndDay('');
    setEndYear('');
    setStartDate(null);
    setEndDate(null);
    setIsFilterOpen(false);
  };

  // State for status filter: 'all', 'pending', or 'completed'
  const [statusFilter, setStatusFilter] = useState<'all' | 'pending' | 'completed'>('all');
  // Search filter state and debounced value
  const [searchInput, setSearchInput] = useState<string>('');
  const [debouncedSearchTerm, setDebouncedSearchTerm] = useState<string>('');

  // Debounce search input to avoid frequent updates
  useEffect(() => {
    const handler = setTimeout(() => setDebouncedSearchTerm(searchInput), 300);
    return () => clearTimeout(handler);
  }, [searchInput]);

  // Filter interactions based on date range and status
  const filteredInteractions = interactions
    .filter((interaction) => {
      if (!startDate) {
        return true;
      }

      const interactionDate = interaction.receivedAt;

      if (endDate) {
        return isWithinInterval(interactionDate, {
          start: startDate,
          end: endDate
        });
      }

      // If only start date is selected, match that specific day
      return (
        interactionDate.getDate() === startDate.getDate() &&
        interactionDate.getMonth() === startDate.getMonth() &&
        interactionDate.getFullYear() === startDate.getFullYear()
      );
    })
    .filter((interaction) => {
      if (statusFilter === 'all') {
        return true;
      }
      return interaction.status === statusFilter;
    })
    .filter((interaction) => {
      if (!(debouncedSearchTerm && debouncedSearchTerm.trim().length > 0)) {
        return true;
      }
      const term = debouncedSearchTerm.toLowerCase();
      return (
        interaction.subject.toLowerCase().includes(term) ||
        (interaction.body ?? '').toLowerCase().includes(term)
      );
    });

  // Get the selected interaction data
  const selectedInteractionData = selectedInteraction
    ? interactions.find((i) => i.id === selectedInteraction)
    : null;

  // Handle review click for full screen mode
  const handleReviewClick = (interactionId: string) => {
    setSelectedInteraction(interactionId);
    setIsFullScreenMode(true);
  };
  // Toggle inline expansion of audit trail
  const handleToggleExpand = (interactionId: string) => {
    setIsFullScreenMode(false);
    setSelectedInteraction((prev) => (prev === interactionId ? null : interactionId));
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
        onSaveMessage={fetchInteractions}
      />
    );
  }

  // Regular list view
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div className="space-y-1">
          <h2 className="text-2xl font-semibold tracking-tight">Interactions</h2>
          <p className="text-sm text-muted-foreground">
            Review and manage recent student interactions
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" onClick={() => setIsFilterOpen(true)}>
            <Calendar className="h-4 w-4" />
            {formatDateRange()}
            <ChevronDown className="h-3 w-3 opacity-50" />
          </Button>

          <Dialog open={isFilterOpen} onOpenChange={setIsFilterOpen}>
            <DialogContent className="sm:max-w-[425px]">
              <DialogHeader>
                <DialogTitle className="text-primary">Select Date Range</DialogTitle>
                <DialogDescription>
                  Choose start and end dates to filter interactions
                </DialogDescription>
              </DialogHeader>

              <div className="space-y-4 py-4">
                <div>
                  <h4 className="text-sm font-medium mb-2">Start Date</h4>
                  <div className="grid grid-cols-3 gap-2">
                    <Select value={startMonth} onValueChange={setStartMonth}>
                      <SelectTrigger variant="secondary">
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
                      <SelectTrigger variant="secondary">
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
                      <SelectTrigger variant="secondary">
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
                      <SelectTrigger variant="secondary">
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
                      <SelectTrigger variant="secondary">
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
                      <SelectTrigger variant="secondary">
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
                <Button variant="outline" onClick={clearDateRange}>
                  Clear
                </Button>
                <Button
                  variant="default"
                  onClick={() => setIsFilterOpen(false)}
                  disabled={!startDate}
                >
                  Apply Filter
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>

          <Select
            value={statusFilter}
            onValueChange={(value: string) =>
              setStatusFilter(value as 'all' | 'pending' | 'completed')
            }
          >
            <SelectTrigger variant="outline" className="w-[180px]">
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
              value={searchInput}
              onChange={(e) => setSearchInput(e.target.value)}
            />
          </div>
        </div>
      </div>
      <div className="grid gap-4">
        {filteredInteractions.length > 0 ? (
          filteredInteractions.map((interaction) => (
            <Card key={interaction.id}>
              <CardHeader
                className={cn('p-4', {
                  'cursor-pointer': interaction.status === 'completed'
                })}
                onClick={() => {
                  if (interaction.status === 'completed') {
                    handleToggleExpand(interaction.id);
                  }
                }}
              >
                <div className="flex items-start justify-between">
                  <div className="space-y-1.5">
                    <CardTitle className="text-base">
                      <div className="flex items-center gap-6 w-full">
                        <span
                          className="truncate text-primary w-36 block"
                          title={
                            interaction.studentId
                              ? interaction.studentName
                              : interaction.senderAddress
                          }
                        >
                          {interaction.studentId
                            ? interaction.studentName
                            : interaction.senderAddress}
                        </span>
                        <span className="truncate w-64 block" title={interaction.subject}>
                          {interaction.subject}
                        </span>
                      </div>
                    </CardTitle>
                    <p className="text-sm text-muted-foreground line-clamp-2">{interaction.body}</p>
                  </div>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="ghost" size="sm" className="h-8 w-8 p-0 shrink-0">
                        <MoreVertical className="h-4 w-4" />
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      {interaction.status === 'completed' && (
                        <DropdownMenuItem>View full history</DropdownMenuItem>
                      )}
                      <DropdownMenuItem>Export conversation</DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
              </CardHeader>
              {selectedInteraction === interaction.id && !isFullScreenMode && (
                <CardContent className="border-t bg-muted/50 p-4 space-y-4">
                  <InteractionAuditTrailWrapper interaction={interaction} />
                  <UserActionsTakenWrapper interaction={interaction} />
                </CardContent>
              )}
              <div className="flex items-center justify-between border-t p-4">
                <div className="flex items-center gap-3 text-sm">
                  <Clock className="h-4 w-4 text-muted-foreground" />
                  <span className="text-muted-foreground">
                    {format(interaction.receivedAt, 'MMM d, yyyy')}{' '}
                    {format(interaction.receivedAt, 'h:mm a').toUpperCase()}
                  </span>
                  <Separator orientation="vertical" className="h-4" />
                  <span
                    className={cn(
                      'flex items-center gap-1',
                      interaction.status === 'pending'
                        ? 'text-yellow-500'
                        : interaction.status === 'skipped'
                          ? 'text-gray-500'
                          : 'text-green-500'
                    )}
                  >
                    {interaction.status === 'pending' ? (
                      <Clock className="h-4 w-4" />
                    ) : interaction.status === 'skipped' ? (
                      <SkipForward className="h-4 w-4" />
                    ) : (
                      <CheckCircle2 className="h-4 w-4" />
                    )}
                    {interaction.status === 'pending'
                      ? 'Processing'
                      : interaction.status === 'skipped'
                        ? 'Skipped Evaluation'
                        : 'Ready for Review'}
                  </span>
                </div>
                {interaction.status === 'completed' ? (
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={(e) => {
                      e.stopPropagation();
                      handleReviewClick(interaction.id);
                    }}
                  >
                    Review
                    <ArrowRight className="ml-2 h-4 w-4" />
                  </Button>
                ) : null}
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
                  No interactions found between {format(startDate, 'MMMM dd, yyyy')} and{' '}
                  {format(endDate, 'MMMM dd, yyyy')}
                </>
              ) : startDate ? (
                <>No interactions found for {format(startDate, 'MMMM dd, yyyy')}</>
              ) : (
                'No interactions match your filters'
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
