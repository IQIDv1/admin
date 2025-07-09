"use client";

import React, { useState, useEffect, useRef } from "react";
import { History, Pen, Send, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Textarea } from "@/components/ui/textarea";
import { createClient } from "@/lib/supabase/client";
import {
  getStudentDetails,
  type OutboundMessageVersionSummary,
  type StudentDetails,
} from "@/lib/supabase/queries";

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

export function MessageDetails({ message, onClose }: MessageDetailsProps) {
  const [studentDetails, setStudentDetails] = useState<StudentDetails | null>(null);
  const fetchedIdRef = useRef<string | null>(null);

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
            <Tabs value="detected" className="w-full">
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
                    className="min-h-[300px]"
                    defaultValue={message.suggestedReply?.body || ""}
                    placeholder="Type your response here..."
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
                  <Textarea className="min-h-[200px]" placeholder="Paste the email content here..." />
                </div>
              </TabsContent>
            </Tabs>
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
