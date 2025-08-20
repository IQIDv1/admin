import { User, GraduationCap, DollarSign, MessageSquare } from 'lucide-react';
import type { MessageContextProps } from './context';

export const contextData: MessageContextProps['contextData'] = [
  {
    category: 'Personal Information',
    icon: User,
    color: 'bg-blue-50 border-blue-200',
    iconColor: 'text-blue-600',
    items: [
      {
        dataPoint: 'Student Name: Anna Smith',
        confidence: 'high' as const,
        sources: [
          { name: 'Student Email', details: 'Extracted from email signature', verified: true },
          { name: 'Match (CRM)', details: 'Verified against student records', verified: true }
        ]
      },
      {
        dataPoint: 'Student High School: Huntsville High School',
        confidence: 'high' as const,
        sources: [
          { name: 'Student Email', details: 'Included in email signature', verified: true },
          { name: 'Match (CRM)', details: 'School registration confirmed', verified: true }
        ]
      },
      {
        dataPoint: 'Student Email: AnnaSmith2026@gmail.com',
        confidence: 'high' as const,
        sources: [
          { name: 'Email Header', details: 'From field verification', verified: true },
          { name: 'Email Signature', details: 'Contact information provided', verified: true },
          {
            name: 'Match (CRM)',
            details: 'Email address on file matches student record',
            verified: true
          }
        ]
      }
    ]
  },
  {
    category: 'AL Match Info',
    icon: GraduationCap,
    color: 'bg-purple-50 border-purple-200',
    iconColor: 'text-purple-600',
    items: [
      {
        dataPoint: 'Intended Major: Business',
        confidence: 'high' as const,
        sources: [
          { name: 'Match (CRM)', details: 'Major selection from student profile', verified: true },
          {
            name: 'Student Profile',
            details: 'Business major indicated in application',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Match profile: transcript missing',
        confidence: 'high' as const,
        sources: [
          { name: 'Match (CRM)', details: 'Profile status check', verified: true },
          { name: 'Document Tracking', details: 'Transcript upload pending', verified: true }
        ]
      },
      {
        dataPoint: 'Transcript upload y/n: No',
        confidence: 'high' as const,
        sources: [{ name: 'Match (CRM)', details: 'Document upload status', verified: true }]
      },
      {
        dataPoint: 'College offers:',
        confidence: undefined,
        sources: []
      },
      {
        dataPoint: 'College matches:',
        confidence: undefined,
        sources: []
      },
      {
        dataPoint: 'Enrollment status: Not enrolled',
        confidence: 'high' as const,
        sources: [
          { name: 'Match (CRM)', details: 'No enrollment confirmation received', verified: true }
        ]
      }
    ]
  },
  {
    category: 'Financial Aid Info',
    icon: DollarSign,
    color: 'bg-green-50 border-green-200',
    iconColor: 'text-green-600',
    items: [
      {
        dataPoint: 'FAFSA Submission date: 12/18/2025',
        confidence: 'medium' as const,
        sources: [
          {
            name: 'Student Email',
            details: 'Student reported submission date in inquiry',
            verified: true
          },
          { name: 'Match (CRM)', details: 'FAFSA completion confirmed', verified: true }
        ]
      },
      {
        dataPoint: 'Fin Aid docs received: FAFSA',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Financial Aid (SIS)',
            details: 'FAFSA received December 18, 2025',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Fin Aid docs missing: Tax transcripts, verification worksheet',
        confidence: 'high' as const,
        sources: [
          { name: 'Financial Aid (SIS)', details: 'Required documents pending', verified: true }
        ]
      },
      {
        dataPoint: 'Federal Pell Grant: $7,395 (estimated)',
        confidence: 'medium' as const,
        sources: [{ name: 'FAFSA Processor', details: 'Based on EFC calculation', verified: true }]
      },
      {
        dataPoint: 'Federal Direct Subsidized loan: $3,500',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Federal Aid Calculator',
            details: 'First-year undergraduate limit',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Federal Direct Unsubsidized loan: $2,000',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Federal Aid Calculator',
            details: 'Additional unsubsidized eligibility',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Institutional aid: $2,500 (Alabama Match Scholarship)',
        confidence: 'high' as const,
        sources: [
          {
            name: 'U of Montevallo',
            details: 'Automatic scholarship for Match students',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'State aid: $1,200 (Alabama Student Grant)',
        confidence: 'medium' as const,
        sources: [
          {
            name: 'Alabama Commission on Higher Education',
            details: 'State grant eligibility confirmed',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Award status: Pending verification',
        confidence: 'high' as const,
        sources: [
          { name: 'Financial Aid (SIS)', details: 'Awaiting document submission', verified: true }
        ]
      },
      {
        dataPoint: 'Estimated cost of attendance: $23,660',
        confidence: 'high' as const,
        sources: [{ name: 'U of Montevallo', details: '2025-2026 published COA', verified: true }]
      },
      {
        dataPoint: 'Loan type: Federal Direct Loans',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Financial Aid Package',
            details: 'Standard federal loan program',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Acceptance status: Not yet accepted',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Financial Aid (SIS)',
            details: 'Student has not accepted aid package',
            verified: true
          }
        ]
      }
    ]
  },
  {
    category: 'Previous Interaction History',
    icon: MessageSquare,
    color: 'bg-orange-50 border-orange-200',
    iconColor: 'text-orange-600',
    items: [
      {
        dataPoint: 'First contact: January 15, 2025 - Initial Match notification',
        confidence: 'high' as const,
        sources: [
          { name: 'Match (CRM)', details: 'Automated match notification sent', verified: true },
          { name: 'Email System', details: 'Delivery confirmed', verified: true }
        ]
      },
      {
        dataPoint: 'Follow-up: January 18, 2025 - Transcript reminder sent',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Match (CRM)',
            details: 'Automated reminder for missing transcript',
            verified: true
          },
          { name: 'Email System', details: 'Email opened by student', verified: true }
        ]
      },
      {
        dataPoint: 'Student response: No previous direct communication',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Email System',
            details: 'No prior emails from this student in system',
            verified: true
          },
          {
            name: 'CRM Search',
            details: 'No phone call logs or chat records found',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Related inquiries: 2 similar questions from Huntsville HS students this week',
        confidence: 'medium' as const,
        sources: [
          { name: 'Email System', details: 'Pattern analysis of recent inquiries', verified: true },
          {
            name: 'School Tracking',
            details: 'Multiple students from same high school asking similar questions',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Previous issues resolved: None on record',
        confidence: 'high' as const,
        sources: [
          {
            name: 'Ticket System',
            details: 'No previous support tickets for this student',
            verified: true
          },
          {
            name: 'Financial Aid (SIS)',
            details: 'No prior aid applications or issues',
            verified: true
          }
        ]
      },
      {
        dataPoint: 'Communication preferences: Email (inferred from contact method)',
        confidence: 'medium' as const,
        sources: [
          { name: 'Student Email', details: 'Student chose to contact via email', verified: true },
          {
            name: 'Match (CRM)',
            details: 'No phone number or text preferences on file',
            verified: false
          }
        ]
      }
    ]
  }
];
