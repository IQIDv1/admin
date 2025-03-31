import { OpenAI } from "openai";
import { OPENAI_API_KEY } from "../constants";
// import { StudentRecord } from "@/types";

const openai = new OpenAI({ apiKey: OPENAI_API_KEY });

export async function generateResponse({
  emailText,
  senderEmail,
  piiAccess,
  studentRecord,
}: {
  emailText: string;
  senderEmail: string;
  piiAccess: boolean;
  studentRecord: any;
  //   studentRecord?: StudentRecord | null;
}) {
  const systemPrompt = piiAccess
    ? `You are a university financial aid advisor responding with full student access.`
    : `You are a university financial aid advisor but cannot access specific student data.`;

  const userPrompt = `
Email received:

"${emailText}"

${piiAccess ? `Student Info:\n${JSON.stringify(studentRecord, null, 2)}` : ""}

Write a helpful, supportive, professional response using institutional messaging.
- Acknowledge urgency
- Answer the question
- Anticipate follow-ups
- Offer next steps
- Suggest resources
- Use warm, student-focused tone
`;

  const completion = await openai.chat.completions.create({
    model: "gpt-4",
    messages: [
      { role: "system", content: systemPrompt },
      { role: "user", content: userPrompt },
    ],
    temperature: 0.7,
  });

  return completion.choices[0].message.content;
}
