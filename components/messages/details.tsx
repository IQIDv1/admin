"use client";

import React, { useState, useEffect, useRef } from "react";
import { History, Pen, X, Save, Clipboard } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { Textarea } from "@/components/ui/textarea";
import { cn } from "@/lib/utils";
import { createClient } from "@/lib/supabase/client";
import {
  getStudentDetails,
  type OutboundMessageVersionSummary,
  type StudentDetails,
} from "@/lib/supabase/queries";
import { saveOutboundResponse } from "@/lib/supabase/queries";
import { useToast } from "@/components/ui/use-toast";

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
    inbound: { action: string; actionData: unknown; }[];
    outbound?: { action: string; actionData: unknown; }[];
  };
  status: "pending" | "completed";
  suggestedReply: OutboundMessageVersionSummary | null;
};
interface MessageDetailsProps {
  message: Interaction;
  onClose: () => void;
  onSaveMessage: () => void;
}

interface StudentInfoProps {
  studentDetails: StudentDetails | null;
  studentId: string;
}

function formatUSD(value: number) {
  if (!isNaN(value)) {
    return value.toLocaleString("en-US", { style: "currency", currency: "USD", maximumFractionDigits: 0 });
  }
  return "N/A";
}

function StudentInfo({ studentDetails, studentId }: StudentInfoProps) {
  return (
    <div>
      <h3 className="text-lg font-semibold mb-4">Student Information</h3>

      {!studentId || !studentDetails ? (
        <p className="text-sm text-red-500">Student details could not be found.</p>
      ) : (
        <div className="space-y-4">
          <div>
            <h4 className="font-medium">Name:</h4>
            <p>
              {studentDetails.student.first_name} {studentDetails.student.last_name}
            </p>
          </div>

          <div>
            <h4 className="font-medium">Student ID:</h4>
            <p>{studentDetails.student.banner_student_id || studentId}</p>
          </div>

          <div>
            <h4 className="font-medium">FAFSA Submission Date:</h4>
            <p>
              {studentDetails.financialAid?.fafsa_submission_date
                ? new Date(
                    studentDetails.financialAid.fafsa_submission_date
                  ).toLocaleDateString()
                : "No financial aid information available."}
            </p>
          </div>

          <div>
            <h4 className="font-medium">Cost of Attendance (COA):</h4>
            <p>
              {typeof studentDetails.financialAid?.cost_of_attendance === 'number'
                ? formatUSD(studentDetails.financialAid.cost_of_attendance)
                : "N/A"}
            </p>
          </div>

          <div>
            <h4 className="font-medium">Award Status:</h4>
            <p>{studentDetails.financialAid?.award_status || "N/A"}</p>
          </div>

          <div>
            <h4 className="font-medium">Enrollment Status:</h4>
            <p>{studentDetails.academic?.enrollment_status || "N/A"}</p>
          </div>

          <div>
            <h4 className="font-medium">Current Aid Status:</h4>
            {studentDetails.currentAid ? (
              <ul className="list-disc pl-5 space-y-1">
                <li>
                  Federal Pell Grant: {typeof studentDetails.currentAid.federal_pell_grant === 'number'
                    ? formatUSD(studentDetails.currentAid.federal_pell_grant)
                    : "N/A"}
                </li>
                <li>
                  Federal Direct Subsidized: {typeof studentDetails.currentAid.federal_direct_subsidized === 'number'
                    ? formatUSD(studentDetails.currentAid.federal_direct_subsidized)
                    : "N/A"}
                </li>
                <li>
                  Federal Direct Unsubsidized: {typeof studentDetails.currentAid.federal_direct_unsubsidized === 'number'
                    ? formatUSD(studentDetails.currentAid.federal_direct_unsubsidized)
                    : "N/A"}
                </li>
              </ul>
            ) : (
              <p>No current aid information available.</p>
            )}
          </div>

          <div>
            <h4 className="font-medium">Outstanding Requirements:</h4>
            {studentDetails.financialAid?.outstanding_requirements ? (
              <ul className="list-disc pl-5 space-y-1">
                {studentDetails.financialAid.outstanding_requirements
                  .split(",")
                  .map((req, idx) => (
                    <li key={idx}>{req.trim()}</li>
                  ))}
              </ul>
            ) : (
              <p>No outstanding requirements.</p>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

export function MessageDetails({ message, onClose, onSaveMessage }: MessageDetailsProps) {
  const [studentDetails, setStudentDetails] = useState<StudentDetails | null>(null);
  const fetchedIdRef = useRef<string | null>(null);
  const { toast } = useToast();
  const [isEditing, setIsEditing] = useState(false);

  // Track suggested reply versions locally
  const [suggestedReplyState, setSuggestedReplyState] = useState<OutboundMessageVersionSummary | null>(message.suggestedReply);
  const hasSuggested = Boolean(suggestedReplyState);

  // Draft response state
  const [draftResponse, setDraftResponse] = useState(suggestedReplyState?.body || "");
  useEffect(() => {
    setSuggestedReplyState(message.suggestedReply);
  }, [message.suggestedReply]);
  useEffect(() => {
    setDraftResponse(suggestedReplyState?.body || "");
  }, [suggestedReplyState]);

   // Save handler
  const handleSave = async () => {
    try {
      const supabase = createClient();
      const subject = `Re: ${message.subject}`;
      const { version } = await saveOutboundResponse(supabase, message.id, subject, draftResponse);
      setSuggestedReplyState(version);
      setIsEditing(false);
      onSaveMessage();
      toast({
        title: 'Your response has been saved!',
        variant: 'default'
      });
    } catch (err) {
      console.error('Save error:', err);
      toast({
        title: 'There was an error saving your response. Please try again later.',
        variant: 'destructive'
      });
    }
  };

  // Copy handler
  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(draftResponse);
      toast({
        title: 'Copied to clipboard!',
        variant: 'default'
      });
    } catch (err) {
      console.error('Copy error:', err);
      toast({
        title: 'We were unable to copy the response to the clipboard.',
        variant: 'destructive'
      });
    }
  };

  useEffect(() => {
    // Only fetch once per student ID
    if (fetchedIdRef.current !== message.studentId) {
      fetchedIdRef.current = message.studentId;
      const supabase = createClient();
      const fetchStudentDetails = async () => {
        try {
          const details = await getStudentDetails(supabase, message.studentId);
          setStudentDetails(details);
        } catch (err) {
          console.error("Error fetching student details:", err);
          setStudentDetails(null);
        }
      };

      fetchStudentDetails();
    }
  }, [message.studentId]);

  const onCloseHandler = () => {
    setStudentDetails(null);
    onClose();
  };

  return (
    <div className="fixed inset-0 z-50 bg-background">
      <div className="flex h-full flex-col">
        <header className="flex h-[52px] items-center justify-between border-b px-6">
          <div className="flex items-center gap-2">
            <h1 className="text-xl font-semibold text-primary">Write Email</h1>
          </div>
          <Button variant="ghost" size="icon" onClick={onCloseHandler}>
            <X className="h-5 w-5" />
          </Button>
        </header>

        <div className="flex flex-1 overflow-hidden">
          <div className="flex-1 overflow-auto p-6">
            <div className="w-full">
              <div className="flex justify-end items-center mb-4">
                <Button variant="outline" className="text-primary">
                  <History className="mr-2 h-4 w-4" />
                  Show History
                </Button>
              </div>

              <div className="space-y-4">
                <div className="space-y-2">
                  <h3 className="text-lg font-medium">
                    Detected Email: {message.subject}
                  </h3>
                  <Textarea
                    className="min-h-[200px] bg-muted/50"
                    readOnly
                    value={message.body || "No email content detected."}
                  />
                </div>

                <div className="space-y-2">
                  <h3 className="text-lg font-medium">Draft Response:</h3>
                  <Textarea
                    className={cn(
                      "min-h-[300px]",
                      {
                        "bg-muted/50": hasSuggested && !isEditing,
                      }
                    )}
                    value={draftResponse}
                    onChange={(e) => setDraftResponse(e.target.value)}
                    placeholder="Type your response here..."
                    readOnly={hasSuggested && !isEditing}
                  />
                </div>

                <div className="flex justify-end gap-2">
                  {isEditing ? (
                    <>
                      <Button
                        variant="outline"
                        onClick={() => {
                          setDraftResponse(message.suggestedReply?.body || "");
                          setIsEditing(false);
                        }}
                      >
                        Cancel
                      </Button>
                      <Button variant="outline" onClick={handleSave}>
                        <Save className="mr-2 h-4 w-4" />
                        Save Response
                      </Button>
                      <Button disabled>
                        <Clipboard className="mr-2 h-4 w-4" />
                        Copy to Clipboard
                      </Button>
                    </>
                  ) : (
                    <>
                      {hasSuggested ? (
                        <Button
                          variant="outline"
                          onClick={() => setIsEditing(true)}
                        >
                          <Pen className="mr-2 h-4 w-4" />
                          Edit Response
                        </Button>
                      ) : draftResponse ? (
                        <Button variant="outline" onClick={handleSave}>
                          <Save className="mr-2 h-4 w-4" />
                          Save Response
                        </Button>
                      ) : (
                        <Button variant="outline" disabled>
                          <Pen className="mr-2 h-4 w-4" />
                          Edit Response
                        </Button>
                      )}
                      <Button onClick={handleCopy} disabled={!hasSuggested}>
                        <Clipboard className="mr-2 h-4 w-4" />
                        Copy to Clipboard
                      </Button>
                    </>
                  )}
                </div>
              </div>
            </div>
          </div>

          <div className="w-[350px] border-l p-6 overflow-y-auto">
            <div className="space-y-6">
              <StudentInfo
                studentDetails={studentDetails}
                studentId={message.studentId}
              />

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
                    <Button variant="link" className="text-blue-500 p-0 h-auto">
                      View Data
                    </Button>
                  </div>

                  <div className="bg-slate-50 p-4 rounded-md">
                    <h4 className="font-medium text-primary">EDConnect</h4>
                    <p className="text-sm mb-2">
                      FAFSA submission date, EFC, and verification status
                    </p>
                    <Button variant="link" className="text-blue-500 p-0 h-auto">
                      View Data
                    </Button>
                  </div>

                  <div className="bg-slate-50 p-4 rounded-md">
                    <h4 className="font-medium text-primary">PeopleSoft API</h4>
                    <p className="text-sm mb-2">
                      Student account balance and financial aid status
                    </p>
                    <Button variant="link" className="text-blue-500 p-0 h-auto">
                      View Data
                    </Button>
                  </div>

                  <div className="bg-slate-50 p-4 rounded-md">
                    <h4 className="font-medium text-primary">Outlook API</h4>
                    <p className="text-sm mb-2">
                      Recent email communications with the student
                    </p>
                    <Button variant="link" className="text-blue-500 p-0 h-auto">
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
