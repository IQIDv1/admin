-- Auto-generated seed for inbound messages and student mappings

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '5737afb4-720d-4e4a-aebb-8c774a17303b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. I am reaching out regarding my financial aid application. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', 'da1cac3e-5562-46ff-8596-7af12ff2cb6e', '7f58e557-b35a-4acd-a0b4-89edc1f7c13b', '2025-06-12T05:50:05.893960'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '5737afb4-720d-4e4a-aebb-8c774a17303b', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '8b546d1b-8b03-4f9f-ae13-2702d3090ab8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. Could you please provide me with an update on the current status? Thank you for your time and assistance.', 'microsoft', '34eef03e-3ad2-41b0-9b77-6709bbf7944d', '79be1537-63da-41f7-a94e-8a857683fead', '2025-06-24T06:21:05.894714'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '8b546d1b-8b03-4f9f-ae13-2702d3090ab8', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '701365f0-bf57-4a4a-b34e-b97947c93864', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. Thank you for your time and assistance. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', '898440be-e0b3-4ac8-9f34-78ab409eecdc', '40134389-3a07-4768-b2e8-ea12eff14c1e', '2025-06-30T16:20:05.895075'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '701365f0-bf57-4a4a-b34e-b97947c93864', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '6c3e5066-4b97-4077-9495-5853b82b639c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit. I hope this message finds you well. I am reaching out regarding my financial aid application.', 'microsoft', 'f20d6e4f-3153-4007-a8f9-4d2cc83419ac', '490d84db-18cd-4462-b3ca-fc1739cad54e', '2025-06-25T12:10:05.895180'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '6c3e5066-4b97-4077-9495-5853b82b639c', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'cff45859-e165-4f2d-93bf-a0840641ec56', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit. I am reaching out regarding my financial aid application.', 'microsoft', 'a1ac3c1e-f93a-418e-87dd-9f0206a623b3', '3f51eeca-c941-4529-99f4-12a8cea8d07b', '2025-06-22T14:42:05.895287'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'cff45859-e165-4f2d-93bf-a0840641ec56', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f12ad570-5072-4b94-a1bf-89760a6ccae3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit.', 'microsoft', '4237009c-43b2-4a6b-8e35-c3f50658429e', 'e0054d5d-f230-43d1-8264-255f6db0c4e8', '2025-06-12T14:37:05.895343'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f12ad570-5072-4b94-a1bf-89760a6ccae3', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '5a2c8cba-28f5-42f4-ae1a-646b899eda3b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I hope this message finds you well. I appreciate your help with this matter.', 'microsoft', '73637c65-cb0d-40d5-987d-8c6373c0a24d', '4bbed96a-c590-4ffc-aaf2-47b66a5b03c3', '2025-06-24T09:48:05.895378'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '5a2c8cba-28f5-42f4-ae1a-646b899eda3b', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ab0b5f91-5c12-42e1-8a2f-3d96ae34abe4', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. I hope this message finds you well.', 'microsoft', 'ccc33930-6b3e-4409-9176-171285215b15', '3a11791d-34ab-4886-a2d5-170e94e040f8', '2025-06-10T15:49:05.895442'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ab0b5f91-5c12-42e1-8a2f-3d96ae34abe4', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a7d0e690-a60e-4560-b5e4-8bd74f42102e', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I appreciate your help with this matter. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '4858fe7d-26cc-4416-9089-ecfd9884dda3', 'f391b6f2-0d5a-4860-a583-3ae11effaa61', '2025-07-01T08:46:05.895526'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a7d0e690-a60e-4560-b5e4-8bd74f42102e', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '86fe6261-7610-461a-9ffe-a9794dda048a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Looking forward to your prompt response. Thank you for your time and assistance. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', '0f7552c5-2171-4d03-8b3e-c4a0930a2e8d', '51051b85-0485-42fd-9314-34ac54092ece', '2025-06-30T04:32:05.895925'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '86fe6261-7610-461a-9ffe-a9794dda048a', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ef40bdba-5e87-429c-8177-a421979d40f4', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. I am reaching out regarding my financial aid application.', 'microsoft', '3021228e-15ea-4a2a-9fdd-bd0515f5a785', '9582b799-7ec4-43b1-9b7c-511218f9b2b0', '2025-06-13T08:01:05.896025'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ef40bdba-5e87-429c-8177-a421979d40f4', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1eff6aa1-d96c-4804-8b93-fabfed4672dd', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I hope this message finds you well. I appreciate your help with this matter. Looking forward to your prompt response. Feel free to contact me if you need further information.', 'microsoft', 'd7ffc8cf-70d3-4665-beaa-5d4b60f37239', '1b87395c-dec9-4fd8-94ae-e1d587a5f625', '2025-06-23T14:01:05.896126'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1eff6aa1-d96c-4804-8b93-fabfed4672dd', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'b64e10e8-212e-4a78-89f2-b8f94a5fe38d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. Feel free to contact me if you need further information. Looking forward to your prompt response.', 'microsoft', '4fe297bc-ad83-42f4-8a72-be5c0ad2208d', '76a98105-8bea-475b-b011-3434ed1a155d', '2025-06-28T00:06:05.896201'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'b64e10e8-212e-4a78-89f2-b8f94a5fe38d', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ac666a2f-5735-4891-aece-2ad5d9f706da', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? Thank you for your time and assistance.', 'microsoft', '087d18f6-a26b-4525-bebc-e0fd84444538', 'be0c5c70-4267-4a21-8ff9-8b0f339a6eaa', '2025-06-27T21:23:05.896298'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ac666a2f-5735-4891-aece-2ad5d9f706da', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '94f5909e-1e71-4212-946d-55cb2d10c0ae', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status? Thank you for your time and assistance.', 'microsoft', 'fe090e07-30ed-49e7-9688-2a128ce99889', '32da647c-5199-4ec0-853d-8a53f305e0b5', '2025-07-01T05:38:05.896362'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '94f5909e-1e71-4212-946d-55cb2d10c0ae', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'eb096c88-ea75-4eb7-a2ae-1912eb816005', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Thank you for your time and assistance. I appreciate your help with this matter. Could you please provide me with an update on the current status?', 'microsoft', '2f474d63-a783-4656-af10-4868d8a336c8', '6fd32e99-cddc-48c8-90da-a95618494d42', '2025-06-21T03:14:05.896417'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'eb096c88-ea75-4eb7-a2ae-1912eb816005', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '56e4a381-1e66-42cf-aa03-db8bbf41f200', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance. Could you please provide me with an update on the current status?', 'microsoft', 'f454620f-cd1e-4e8e-ab9e-2fb16c52a9c6', '6de4868c-cc84-4f52-a006-ae7146f82f0f', '2025-06-10T16:15:05.896490'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '56e4a381-1e66-42cf-aa03-db8bbf41f200', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '926a71f2-7d70-4fd4-b5ef-a11b9f4e51a1', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit. I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', 'b07d25ad-f33a-483e-b701-be1ef796a66a', '390b77e0-2143-4baa-9357-9f51307c56d0', '2025-06-17T23:20:05.896531'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '926a71f2-7d70-4fd4-b5ef-a11b9f4e51a1', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f5bede58-6898-4d5a-8008-c704e7e46990', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. I appreciate your help with this matter. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', '518d330f-6852-48b1-b6dc-7af9f12f1a33', '2018438d-263e-48a6-b7cf-ecbc209c2c5b', '2025-06-20T16:02:05.896587'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f5bede58-6898-4d5a-8008-c704e7e46990', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '623ea1ab-63ea-4518-9c14-dc38767ef3a5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance.', 'microsoft', 'bca0e938-05f6-4679-830d-1fb7f296aa87', '06cae338-bd95-445c-a6f2-e1698f6b6c5e', '2025-06-19T23:03:05.897194'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '623ea1ab-63ea-4518-9c14-dc38767ef3a5', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '30bca1e2-3f28-48e1-8d01-22b085114be5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. I appreciate your help with this matter. Thank you for your time and assistance. I hope this message finds you well.', 'microsoft', '94519684-43ab-4e11-8d37-56ff3604541d', '64994127-93aa-44df-8d69-6b21d493c311', '2025-06-17T22:55:05.897264'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '30bca1e2-3f28-48e1-8d01-22b085114be5', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'd8fd28f5-5088-4847-ba2d-60cdaeabf3a5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I appreciate your help with this matter. I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', '41cc6397-4940-402b-83c6-f97dd628ab03', 'd355a92a-14a7-4cca-9aa7-a941c21a8009', '2025-06-13T13:54:05.897596'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'd8fd28f5-5088-4847-ba2d-60cdaeabf3a5', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4a400eaf-2a19-4efd-9390-7e4c05030ca3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', 'c741f6dc-126f-4329-86d4-c663ef032260', '14cdbca4-73f3-4a35-9618-7f68547810e1', '2025-06-11T01:49:05.898130'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4a400eaf-2a19-4efd-9390-7e4c05030ca3', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '0242802d-2214-4815-be16-3182ffc7b3b1', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. Could you please provide me with an update on the current status? Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit.', 'microsoft', '3657c196-26bb-4fbd-9a99-0a2c4486b365', 'd8c99e28-1028-429b-ac64-dd515f498e18', '2025-06-15T12:20:05.898265'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '0242802d-2214-4815-be16-3182ffc7b3b1', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'c40fda45-8333-41cd-8b78-833526e7590d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I hope this message finds you well. Thank you for your time and assistance. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', 'd1911a8c-9bbd-420a-bcd8-8dcf34fca1a3', '0aad5c79-97c6-449f-9065-647c45dd3a64', '2025-06-17T13:29:05.898343'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'c40fda45-8333-41cd-8b78-833526e7590d', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f3c0f964-178a-4728-937d-86d3f26e2d0b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', 'fac40b84-31a7-4c96-8dc4-d6de9b35b862', 'e7f8a4ec-1fc0-4efa-a37a-2e8419bffab1', '2025-06-12T12:20:05.898396'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f3c0f964-178a-4728-937d-86d3f26e2d0b', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '488a315d-478d-4ad0-a14c-6cb2a5bbf199', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', 'd83aed08-5de8-4bc7-bd46-032524667e77', 'd4ebf23e-09c7-4abb-8886-2c2ce956d560', '2025-06-10T23:39:05.898471'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '488a315d-478d-4ad0-a14c-6cb2a5bbf199', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1ec4783d-ce87-46b1-8a23-ebbc3e461cb9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Feel free to contact me if you need further information. I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', 'c125c6ea-751a-4baa-add9-a54d6de4361a', '39bdadb0-4959-4c53-821d-ebb1df8df8fe', '2025-06-28T01:00:05.898536'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1ec4783d-ce87-46b1-8a23-ebbc3e461cb9', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '26f507bc-bbed-45fa-a37a-0a222a821871', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I hope this message finds you well. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', 'f1091a50-9b08-43ad-a41e-74aba5e5e355', '269a2a0d-f6bb-45eb-9a07-b447e94b3a95', '2025-06-10T15:28:05.898744'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '26f507bc-bbed-45fa-a37a-0a222a821871', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '7aeb1790-89f6-4545-920b-7912eba8c824', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I am reaching out regarding my financial aid application. Thank you for your time and assistance. Feel free to contact me if you need further information. Looking forward to your prompt response.', 'microsoft', '61b6aa4f-6be2-44be-b6e9-47886bfbb458', '2d947bdb-fa3b-4d2c-ac71-6064620691b6', '2025-06-25T09:19:05.898816'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '7aeb1790-89f6-4545-920b-7912eba8c824', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '830001d9-4eb7-48ff-b13c-f03989ba063d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Please let me know if there are any additional documents I need to submit. I hope this message finds you well. I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', '47f50f00-e050-4aa3-9146-5e990549b573', 'c23ea20e-0aaa-4af4-8d5c-0357470802d3', '2025-06-20T13:42:05.898919'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '830001d9-4eb7-48ff-b13c-f03989ba063d', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'afd4e632-8067-4fd3-b2af-a993e9c13535', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', 'f8682b8f-f010-4edb-ba64-97f306d7b05f', 'ad47f55f-e47c-4883-908e-cfc3138c27a5', '2025-06-10T17:38:05.899211'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'afd4e632-8067-4fd3-b2af-a993e9c13535', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '663287c0-c6a6-4662-98a8-72afef848cbb', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. I appreciate your help with this matter.', 'microsoft', 'ba715fcf-1e0e-4026-95ff-1e2fcb16e4de', '9977443a-8712-4d38-8286-53e92639b4ed', '2025-06-11T02:16:05.899308'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '663287c0-c6a6-4662-98a8-72afef848cbb', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'd2a16996-646e-4034-ac0b-c9fc19f893a2', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I appreciate your help with this matter. Looking forward to your prompt response. Thank you for your time and assistance.', 'microsoft', 'c66e1a3f-7295-420e-8004-f586588fd0d4', '8f414afa-7502-466d-be53-dc7a07184f83', '2025-06-25T04:59:05.899402'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'd2a16996-646e-4034-ac0b-c9fc19f893a2', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '97c9ce44-5b94-4dd2-aa37-fe809568e529', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I appreciate your help with this matter. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', 'cebb7bf8-6616-4333-8709-d1129dec7d0f', 'b1b426c9-10b0-45c5-ac3b-7b42f6b5ae59', '2025-06-16T07:26:05.899458'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '97c9ce44-5b94-4dd2-aa37-fe809568e529', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ff377e79-f201-4379-992f-e96ddb0d8d10', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Thank you for your time and assistance. I hope this message finds you well. Please let me know if there are any additional documents I need to submit.', 'microsoft', '2b2aa46e-7710-48e3-8740-14bb3cc034b7', 'c942672b-6ad5-4d99-9426-f50442291b1b', '2025-07-01T06:16:05.899502'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ff377e79-f201-4379-992f-e96ddb0d8d10', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '8eee71d1-8517-441a-b176-9c6ae0cc2803', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I hope this message finds you well. Thank you for your time and assistance.', 'microsoft', '313e241b-6e2e-4ac5-9e53-535bb42ec996', 'bf414ea9-b770-4f15-803c-6ea92757d3d7', '2025-06-23T13:29:05.899550'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '8eee71d1-8517-441a-b176-9c6ae0cc2803', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '7adde74b-fd60-4388-9802-0021a8aefbb3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Could you please provide me with an update on the current status? Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit.', 'microsoft', '5b99f6e0-f3a9-4c58-8f79-8f574d0cb463', '9f08bfd3-e9bf-429a-922b-7a8a1fe1d080', '2025-06-23T13:56:05.899744'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '7adde74b-fd60-4388-9802-0021a8aefbb3', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '561a03dd-b3f5-4790-be5e-de2551b502c0', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. I appreciate your help with this matter.', 'microsoft', '5e2ea757-80c5-498c-9656-38369745a35b', '2720ae55-61a4-4428-9fbd-6bce8ee23fdd', '2025-06-26T20:14:05.899817'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '561a03dd-b3f5-4790-be5e-de2551b502c0', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '331004d2-6d44-4054-9e1f-e0752f8576bd', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. Thank you for your time and assistance. Could you please provide me with an update on the current status? Feel free to contact me if you need further information.', 'microsoft', '05d837c2-5f9e-4de3-980f-2793aecdb126', '1a663b90-1088-4c29-8f01-33186122a086', '2025-06-19T15:46:05.899872'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '331004d2-6d44-4054-9e1f-e0752f8576bd', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '899e5fc0-0f93-48bd-9544-458b1ef9b908', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I appreciate your help with this matter. Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit.', 'microsoft', '9b8b0af9-50bf-4573-98e8-317462a9da66', '4ecaa076-e35c-4060-8b3e-dce16db2f406', '2025-06-30T06:53:05.899906'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '899e5fc0-0f93-48bd-9544-458b1ef9b908', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '29229093-5c09-4545-badc-07c32dfcd869', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', 'b1a8d4fe-defe-4be5-a78c-279a8985f410', 'ece87393-d387-4913-9cbf-f4304053d19a', '2025-06-19T10:34:05.899972'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '29229093-5c09-4545-badc-07c32dfcd869', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '15242a17-f84e-42bc-b75d-efb48a709b36', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. I hope this message finds you well. Feel free to contact me if you need further information.', 'microsoft', 'c2a1bd24-98b2-4c50-ace3-f4c6ef76a776', 'd13859f3-e72b-453e-96e8-ce1f886c295c', '2025-06-13T00:29:05.900043'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '15242a17-f84e-42bc-b75d-efb48a709b36', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'b76dfc13-e5ba-4d1c-9fc0-284c150bde05', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Looking forward to your prompt response. I appreciate your help with this matter. Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit.', 'microsoft', '8cac9864-3741-4426-8d12-7b58a85605c0', '5674395d-333a-46be-a205-d0bd06f77809', '2025-06-11T21:58:05.900443'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'b76dfc13-e5ba-4d1c-9fc0-284c150bde05', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '38be4f3a-0771-47fe-ab36-f1af8d891bdd', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Looking forward to your prompt response. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '102598a4-21f2-4859-b8e2-02a2665e488c', '64b97d83-32bd-4c37-a543-123001596c66', '2025-06-12T08:10:05.900518'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '38be4f3a-0771-47fe-ab36-f1af8d891bdd', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2d9caa18-fad0-4ac5-b3f7-c7ffc3ee3f55', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Thank you for your time and assistance. Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit.', 'microsoft', '99f149e4-6b5c-44c1-93e3-00e2f9602785', 'fb7be08f-7bd4-4da0-8b48-a00dc0847ad2', '2025-06-21T11:13:05.900553'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2d9caa18-fad0-4ac5-b3f7-c7ffc3ee3f55', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '96136def-70af-41c6-9bf4-ca1f4ebf3974', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status?', 'microsoft', '3454f34d-6076-458d-bcd6-dfc9206f0992', '5c565189-1ba7-408e-9d75-430f4845af66', '2025-06-23T14:11:05.900685'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '96136def-70af-41c6-9bf4-ca1f4ebf3974', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '62a6c108-357e-40c3-84bf-142dca631a6d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Feel free to contact me if you need further information. Thank you for your time and assistance. Looking forward to your prompt response.', 'microsoft', '7ed0ce51-befd-49e5-ab16-6fdb7c4b02fa', '2ae59810-63b1-4ef1-8724-ef4d4fb64f57', '2025-06-21T04:39:05.900771'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '62a6c108-357e-40c3-84bf-142dca631a6d', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4907bfba-3710-42a6-b79d-638b6dd2ee24', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. I hope this message finds you well.', 'microsoft', '6b62e391-1b7c-4063-8161-b3b4062f6872', '6d891d94-b1b1-4899-a6d0-cf2e05ce1c09', '2025-06-19T12:02:05.900824'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4907bfba-3710-42a6-b79d-638b6dd2ee24', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'f7d20f06-ce30-4ba7-85d6-0783c4dc2d5a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', '4a0c8a4b-79cf-4d4f-b276-dbcddceca157', 'd4788679-7f50-4c39-b104-23dc92aca84a', '2025-06-28T01:39:05.900892'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'f7d20f06-ce30-4ba7-85d6-0783c4dc2d5a', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '8de4a6f5-3c03-425e-8cb2-34c02ea77596', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. I hope this message finds you well. Could you please provide me with an update on the current status? I appreciate your help with this matter.', 'microsoft', '3939c70f-53fb-4fbb-ac49-6dea90c0240d', 'b093b0f7-65da-44f0-b404-723a4307e78f', '2025-06-16T12:38:05.900945'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '8de4a6f5-3c03-425e-8cb2-34c02ea77596', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ec16a318-b2de-4cb2-95fd-48984303afed', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. I hope this message finds you well. I appreciate your help with this matter. Could you please provide me with an update on the current status?', 'microsoft', '78c962d3-9b0d-4caf-8c04-a1e9c28839d7', '8426e9e4-a5c5-42c5-b7a2-9c2e07189194', '2025-06-23T12:12:05.901021'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ec16a318-b2de-4cb2-95fd-48984303afed', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4323b74f-7ab6-48ea-8c59-40bb69d77474', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. I hope this message finds you well.', 'microsoft', '5b6ddcc9-288c-4d8f-b48e-9e71e1d4c615', '3504e198-cdb0-42e4-b767-e917c0ba4a55', '2025-06-17T04:21:05.901057'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4323b74f-7ab6-48ea-8c59-40bb69d77474', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'aa88377b-9c90-4462-a2f7-ba242a91b1d5', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Looking forward to your prompt response. I hope this message finds you well. Feel free to contact me if you need further information.', 'microsoft', 'a46effe4-277e-4191-92d5-916334c4721d', 'e5bc5357-a822-4d10-8b6d-0e23b88e25a2', '2025-06-20T17:00:05.901096'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'aa88377b-9c90-4462-a2f7-ba242a91b1d5', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '561d1037-8699-40df-87c1-79348973b18a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. I hope this message finds you well. Thank you for your time and assistance. I am reaching out regarding my financial aid application.', 'microsoft', '5bdae544-dc84-4ac0-b880-313cdd9cac01', 'db0b97e8-67cf-4fae-980e-7c1d04ffec65', '2025-06-17T06:53:05.901492'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '561d1037-8699-40df-87c1-79348973b18a', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a5b3b301-3235-433a-9b61-01a0a1cbae39', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. I hope this message finds you well. Looking forward to your prompt response.', 'microsoft', 'a648022d-cc8d-4c6b-a7c3-391c6d8d846f', 'c7051fcc-5044-4607-99c2-185c4a321692', '2025-06-30T17:22:05.901782'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a5b3b301-3235-433a-9b61-01a0a1cbae39', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '46bf6049-074f-4a92-af32-c405165f7ae8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', '8c5a30bb-34f5-4dbe-9ce7-7c629760ebf2', '5b4e5e46-14d2-4319-80e0-5b465eb96e74', '2025-06-21T18:12:05.901883'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '46bf6049-074f-4a92-af32-c405165f7ae8', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '4e23e999-3ba4-4ef3-ba93-ef4ab15fb2da', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Could you please provide me with an update on the current status? I hope this message finds you well.', 'microsoft', 'f5b669e8-8041-4eca-8e08-2dce747ba5d1', 'cf66cc74-679c-4108-b7fd-ae0e80e87566', '2025-07-01T13:27:05.901949'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '4e23e999-3ba4-4ef3-ba93-ef4ab15fb2da', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1545a7e9-e843-4843-aa0c-03c568a0722c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. I appreciate your help with this matter. Thank you for your time and assistance. I am reaching out regarding my financial aid application.', 'microsoft', '9d3a9f18-5708-4751-bc6f-f3dcfc73923e', 'ce425ed0-1f4d-4dfe-990f-155daff3fd33', '2025-06-27T03:28:05.902222'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1545a7e9-e843-4843-aa0c-03c568a0722c', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '19ae249d-da5f-41ac-885c-21532e55261d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Looking forward to your prompt response. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', '6a4e1e7b-be76-46d4-b4a6-36e6f0b30f48', '50cca010-e954-4584-8039-e0a6c8ef2b52', '2025-06-26T22:29:05.902593'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '19ae249d-da5f-41ac-885c-21532e55261d', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'c23d8b7f-7aaa-49c5-92c9-c6cced2711f8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. I am reaching out regarding my financial aid application. I hope this message finds you well. Looking forward to your prompt response.', 'microsoft', '00fbef63-fe87-4270-ac1d-e030d4883005', '971d485a-55cc-4572-8fc4-757f2618746b', '2025-06-18T19:35:05.902798'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'c23d8b7f-7aaa-49c5-92c9-c6cced2711f8', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1edf6ad1-986e-4345-ad64-73936e45a6f9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I appreciate your help with this matter. Thank you for your time and assistance. Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit.', 'microsoft', '6c39ca23-f9d4-4e7b-bc3b-49d939856178', 'c73a3c84-8936-49fc-806c-bcea7835bdfe', '2025-06-11T02:18:05.902876'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1edf6ad1-986e-4345-ad64-73936e45a6f9', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '517db238-ce54-4580-94df-06e66091321d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Feel free to contact me if you need further information. Thank you for your time and assistance. I appreciate your help with this matter. Looking forward to your prompt response.', 'microsoft', '298ae7f8-60f0-4c14-999f-cd40d4010d17', '782cf967-4d88-4002-9e4e-34904afbe677', '2025-06-26T10:17:05.902915'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '517db238-ce54-4580-94df-06e66091321d', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '005dcbf6-f601-443d-83f4-c286b0493d75', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Feel free to contact me if you need further information. I am reaching out regarding my financial aid application. Could you please provide me with an update on the current status? Looking forward to your prompt response.', 'microsoft', '109bfe47-94c3-45d6-9634-50ff4acb8e63', 'f15f16a7-9db9-499b-8196-357f6c1ba883', '2025-06-16T09:25:05.902958'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '005dcbf6-f601-443d-83f4-c286b0493d75', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '249a83c1-a3d2-46bc-ac1b-cd948131366c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. Feel free to contact me if you need further information. I hope this message finds you well. Could you please provide me with an update on the current status?', 'microsoft', '21da52df-fb70-4b3f-aa8f-9813f984a103', 'cf24217d-013f-4027-a97d-2113cea23e95', '2025-06-29T09:11:05.903199'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '249a83c1-a3d2-46bc-ac1b-cd948131366c', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '563e2f76-6537-40c9-bdb6-5edeaf4f886e', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. Looking forward to your prompt response.', 'microsoft', '3941b83d-55d3-465f-8688-4297922dffe1', 'acb5f5b7-fda1-4194-bf21-80704304dac1', '2025-06-30T06:15:05.903297'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '563e2f76-6537-40c9-bdb6-5edeaf4f886e', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1a45cfc6-f464-41e6-9a12-ec80991839e2', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. Thank you for your time and assistance.', 'microsoft', '90946821-8be3-425e-a649-b5ea6eb3dd22', '94125995-7179-4798-a743-f5eca720c150', '2025-06-12T19:36:05.903396'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1a45cfc6-f464-41e6-9a12-ec80991839e2', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '77fe0d54-5fda-4eac-b3bf-18d1afc2d5f7', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Looking forward to your prompt response. I hope this message finds you well. I appreciate your help with this matter.', 'microsoft', '73535457-4d66-467d-bd78-93395c1f6513', '9fd7a484-a2be-4f9d-8df6-28971598988b', '2025-06-12T03:24:05.903476'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '77fe0d54-5fda-4eac-b3bf-18d1afc2d5f7', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2f3b553d-a5f1-4479-bf78-a43047bcc6a3', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance.', 'microsoft', 'f75a5d53-6805-465d-a0a4-b55f51592025', '12768f4c-d4a6-4f1e-9537-bf1a5916cdfd', '2025-06-15T05:16:05.903539'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2f3b553d-a5f1-4479-bf78-a43047bcc6a3', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e3125f0f-bfdd-4d9a-a091-9ec33bfff59a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Could you please provide me with an update on the current status? Thank you for your time and assistance. I appreciate your help with this matter. Please let me know if there are any additional documents I need to submit.', 'microsoft', 'b68fce9f-4212-47cc-8f83-6e15eeec45fb', 'ac680ae3-8581-4ef0-9059-e06310e874c2', '2025-06-29T08:17:05.903606'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e3125f0f-bfdd-4d9a-a091-9ec33bfff59a', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'cebc0b30-0adb-443a-a9d4-432f70a94122', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'I hope this message finds you well. Thank you for your time and assistance. Feel free to contact me if you need further information.', 'microsoft', '452b4892-6ea3-453c-9a1b-251120a89491', '0601a8c4-f824-444c-b45b-1cac2e4c6cf5', '2025-06-24T18:32:05.903676'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'cebc0b30-0adb-443a-a9d4-432f70a94122', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e32c83e9-379f-45de-ba98-be4375f0dc92', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter. I am reaching out regarding my financial aid application.', 'microsoft', 'c2665a6e-1268-4fa7-b174-9f45be60ddc9', '0272a707-47db-4660-9777-d8b86977cccb', '2025-06-23T13:46:05.903760'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e32c83e9-379f-45de-ba98-be4375f0dc92', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'dbc52561-0c55-4b2e-8d92-cc12547f886a', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. Feel free to contact me if you need further information.', 'microsoft', 'd5339542-df8f-4c75-b480-d0524f51a6d2', '771fed9a-410a-4258-a0d3-1394680090b4', '2025-06-29T12:33:05.904193'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'dbc52561-0c55-4b2e-8d92-cc12547f886a', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e16d3b95-961f-4f1a-bdd4-8692b12cab02', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Could you please provide me with an update on the current status? I appreciate your help with this matter. I hope this message finds you well.', 'microsoft', '5070c870-3c0d-42e4-baa4-848991184c5e', '5b552727-3040-4e80-a4d7-8d69558034b6', '2025-06-11T08:02:05.904449'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e16d3b95-961f-4f1a-bdd4-8692b12cab02', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2630cdbd-5a3c-4e5d-ac15-b1c52bb36501', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Feel free to contact me if you need further information. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', '8f12b235-bcfd-49f2-b416-69294a776266', '9504a44c-c29a-4e15-8917-5d7c2016a22d', '2025-06-14T17:37:05.904514'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2630cdbd-5a3c-4e5d-ac15-b1c52bb36501', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e95944f9-9b50-41ab-b410-fe2bba132df0', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. Thank you for your time and assistance.', 'microsoft', '49c0dd71-8fea-406b-9fc2-730b3c5de8db', '44e3d977-971b-4367-8bf4-67e1e9925549', '2025-06-26T16:49:05.904559'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e95944f9-9b50-41ab-b410-fe2bba132df0', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e0a4bd53-b795-46c8-a99e-9c61e15158a9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I am reaching out regarding my financial aid application. Looking forward to your prompt response. I hope this message finds you well. Thank you for your time and assistance.', 'microsoft', 'd1acd726-3742-4ddc-b3df-b41a1bc287f5', 'fe00cbea-fc1b-493d-98a1-5dbc325adbd2', '2025-06-23T08:17:05.904625'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e0a4bd53-b795-46c8-a99e-9c61e15158a9', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'bc45e22f-0c67-4b6a-b11f-fc31d2d92c02', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I appreciate your help with this matter. Feel free to contact me if you need further information. Thank you for your time and assistance.', 'microsoft', 'bd2d06d7-3608-432f-9b46-1342e1ea68e4', '287fb739-41f4-4726-b99e-5ea43315728c', '2025-06-19T06:43:05.904660'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'bc45e22f-0c67-4b6a-b11f-fc31d2d92c02', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2d2c44a9-82fe-44d3-bf70-2c17b47d04a8', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Feel free to contact me if you need further information. Looking forward to your prompt response. Could you please provide me with an update on the current status? Please let me know if there are any additional documents I need to submit.', 'microsoft', 'a9691ae6-8a30-4bc9-9d1c-1f4aab37407c', 'bdb7178c-0546-4313-befb-468a5578558b', '2025-06-30T03:35:05.904693'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2d2c44a9-82fe-44d3-bf70-2c17b47d04a8', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ed7a37a6-d0c8-41ad-9ec6-fbd753403f40', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'I hope this message finds you well. Thank you for your time and assistance. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '27737e20-f8d2-4e40-91b3-1e1891f25bb1', '8209d924-0c9a-4ab3-9b8b-13686949d1d8', '2025-06-23T05:31:05.904728'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ed7a37a6-d0c8-41ad-9ec6-fbd753403f40', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a66ea1ff-704e-4af8-b43c-686a19dbe799', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'I hope this message finds you well. Looking forward to your prompt response. I appreciate your help with this matter.', 'microsoft', '0250ee11-3bff-43c8-a144-6265191e3b6b', '4febd48e-65ec-4740-acb2-3d77bd444ee6', '2025-06-18T10:30:05.904773'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a66ea1ff-704e-4af8-b43c-686a19dbe799', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '506d6285-6f02-4629-bb89-e794a14e8bf0', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter. Feel free to contact me if you need further information.', 'microsoft', '1e92c931-c0cb-45d4-9b8c-477bba13f75c', '34688e72-feb4-4778-a01e-74c6a812ec1e', '2025-06-23T00:55:05.904804'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '506d6285-6f02-4629-bb89-e794a14e8bf0', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '604f2ed5-9be2-4c1d-8671-0061f1d3bd67', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'kerry.johnson14@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. Feel free to contact me if you need further information. Looking forward to your prompt response. I am reaching out regarding my financial aid application.', 'microsoft', '37c63180-dc7d-4fcf-aac6-01043ef43523', 'ee03cfa0-b307-44c8-b12c-abfd515182a6', '2025-06-14T04:23:05.904955'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '604f2ed5-9be2-4c1d-8671-0061f1d3bd67', '6256be68-0512-42e9-afc2-8c2627cee1e7'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'b6038582-8b5d-4d24-9cea-7d0cf8fbde9f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.davis52@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. Looking forward to your prompt response. Could you please provide me with an update on the current status?', 'microsoft', '86f6ab42-c762-437b-a67a-d0925cdac4b1', '84dfe01d-7bd3-4fd3-9fde-9947df434ebe', '2025-06-29T23:31:05.905041'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'b6038582-8b5d-4d24-9cea-7d0cf8fbde9f', '71f26f96-af68-4a9a-89c3-1186c2bed0e6'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '87c7774a-a07f-492d-94dd-7c0d7bb065c9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I hope this message finds you well. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', 'f6193693-6e18-4d98-aca8-c93e95b992ca', '6baca7e2-4ea2-4054-bdb2-1474e24de292', '2025-06-18T08:08:05.905083'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '87c7774a-a07f-492d-94dd-7c0d7bb065c9', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e2da47ef-6f06-4228-b019-f28be81683f9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Transcript upload confirmation', 'Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '5cd7f1ea-093f-422d-8a85-bb562da78612', '6863a1b0-1764-4242-a0b5-b23c0f6ad022', '2025-06-13T13:40:05.905116'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e2da47ef-6f06-4228-b019-f28be81683f9', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '95e430c1-7200-4872-8af8-9bb42d4125ed', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', '36f8a8fe-f761-4e25-8daf-a321d6ddfb90', '4538b047-4827-4fb9-8373-b0d4a818e9c6', '2025-06-13T19:42:05.905155'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '95e430c1-7200-4872-8af8-9bb42d4125ed', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'e05708ca-74a5-426e-8032-f88fb1416bd9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'Thank you for your time and assistance. I hope this message finds you well. Looking forward to your prompt response. Please let me know if there are any additional documents I need to submit.', 'microsoft', '394c9963-054e-4199-8ea0-6e41fadcb275', 'ec657a25-07dc-4a57-a2b0-e582e1491920', '2025-06-12T08:45:05.905187'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'e05708ca-74a5-426e-8032-f88fb1416bd9', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '220cfb8d-2488-476e-a8da-a71af9caa20d', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Please let me know if there are any additional documents I need to submit. Feel free to contact me if you need further information. I appreciate your help with this matter.', 'microsoft', 'a8d2959e-529a-4126-ba0c-8509bf99c93e', '1cbdb8af-2454-448e-8e05-8eb713e51f82', '2025-07-01T07:38:05.905217'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '220cfb8d-2488-476e-a8da-a71af9caa20d', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '265927b4-1890-4ed0-87e7-30f57fd20a96', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'emerson.white59@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Feel free to contact me if you need further information. I hope this message finds you well. I appreciate your help with this matter. Thank you for your time and assistance.', 'microsoft', '805eca1f-862e-4d68-a229-2e9f6a13e023', '8fa494d5-d87b-43e1-895e-8324d22543e1', '2025-06-22T03:23:05.905247'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '265927b4-1890-4ed0-87e7-30f57fd20a96', 'f711290a-4d23-40dd-8010-e8c0d681b074'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '7abcfa10-cbfc-4e77-a89c-0ae70c8ea1a6', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. I appreciate your help with this matter.', 'microsoft', '826b40c1-dc97-465a-8a64-25b69fcea9b4', '17dbcc3d-1301-4266-ae88-9c2b22e8a9b1', '2025-06-23T06:40:05.905278'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '7abcfa10-cbfc-4e77-a89c-0ae70c8ea1a6', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'a2a3cae8-6cea-4143-8826-7867cf0b4a7b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'taylor.thompson60@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. I appreciate your help with this matter. I am reaching out regarding my financial aid application. I hope this message finds you well.', 'microsoft', '48af8e7b-d0e1-4e8d-a71f-e78655fba978', '92c780ee-038d-4379-8e8b-5a1aaf2de6aa', '2025-06-15T15:36:05.905354'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'a2a3cae8-6cea-4143-8826-7867cf0b4a7b', 'a870439b-ccf2-48ef-b635-9026027a1177'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '063b591a-fb1e-4f9c-ba94-c7ee5a7fc259', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'finley.jackson49@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Thank you for your time and assistance. Could you please provide me with an update on the current status? I am reaching out regarding my financial aid application. I hope this message finds you well.', 'microsoft', 'b8d3e860-b9df-42c5-88ff-ca384604a2f8', '86aab0ef-74cf-408e-b942-2339a3b19c8e', '2025-06-15T19:34:05.905387'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '063b591a-fb1e-4f9c-ba94-c7ee5a7fc259', '14c0fa81-2347-410c-9182-910107145267'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'ee900590-578d-4dde-9814-24a11b380af9', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Could you please provide me with an update on the current status? Feel free to contact me if you need further information. Looking forward to your prompt response.', 'microsoft', '35b548ff-01b1-4ff2-bc0d-b883a3f461a8', '69d31444-0d62-46a8-bbfe-43a05b9d19c4', '2025-06-19T11:59:05.905418'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'ee900590-578d-4dde-9814-24a11b380af9', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '57964835-9e27-4c68-a191-b4af9365f91c', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance. I hope this message finds you well.', 'microsoft', 'dc806f5d-1112-4dc2-9021-e39790b35c60', 'b72145fc-9e0a-40ef-b22e-05709ecebc0a', '2025-06-16T12:47:05.905449'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '57964835-9e27-4c68-a191-b4af9365f91c', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'dd32204b-0212-4572-9f31-d9587c691299', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'micah.lopez20@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'I am reaching out regarding my financial aid application. Please let me know if there are any additional documents I need to submit. Thank you for your time and assistance. I hope this message finds you well.', 'microsoft', 'a3d1ba6c-3acf-4d44-8d26-376358e8aee8', '3ed24f6d-14a5-47af-87f7-65ed63d9dc64', '2025-06-27T05:56:05.905480'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'dd32204b-0212-4572-9f31-d9587c691299', '25560219-73f8-4f7b-98ae-96b0a9e1986f'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '1bba2be6-62b3-46d6-8e4f-290cd02819af', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'dakota.anderson41@example.edu', 'finaid@montevallo.edu', 'Update on enrollment status', 'Looking forward to your prompt response. I appreciate your help with this matter. Thank you for your time and assistance.', 'microsoft', '04fc2c19-5721-4d95-b6b9-e86d4004b1d8', 'b6ae4219-abb3-48ec-b694-ea569795152d', '2025-06-26T23:20:05.905511'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '1bba2be6-62b3-46d6-8e4f-290cd02819af', 'c8bf63c3-f60c-4fc5-a8fd-cb9363993b99'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  '2d2c0172-5983-41ed-9295-e4cbc0143d4f', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'riley.smith97@example.edu', 'finaid@montevallo.edu', 'Inquiry about loan disbursement', 'Please let me know if there are any additional documents I need to submit. I hope this message finds you well. Looking forward to your prompt response. Feel free to contact me if you need further information.', 'microsoft', 'f4c5367d-1b8b-473a-a692-9b17177b0ad2', '4d91c1b7-3363-40e9-8b95-8dfc51424a77', '2025-06-29T05:44:05.905544'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  '2d2c0172-5983-41ed-9295-e4cbc0143d4f', '7843791b-2a55-415c-9962-558938f63d28'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'afe178e8-857e-412d-8c93-f95c482c9b2b', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'parker.williams73@example.edu', 'finaid@montevallo.edu', 'Question about FAFSA', 'Thank you for your time and assistance. I am reaching out regarding my financial aid application. I appreciate your help with this matter.', 'microsoft', '18cf98ba-4cb7-4ee0-b2a1-3749d568d4b9', '76a6b217-7aa8-4cd2-a06b-5a660c95a550', '2025-06-21T18:55:05.905576'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'afe178e8-857e-412d-8c93-f95c482c9b2b', '78381907-b7ad-4c1d-881e-a3cd0ca092dd'
);

INSERT INTO public.organization_inbound_messages (
  id, organization_id, sender_address, recipient_address, subject, body, provider, message_id, thread_id, received_at
) VALUES (
  'aecef0ab-b65c-4a22-8d5c-4faa33726942', '55a9b012-8dba-48c6-9cc6-ec3b774287d9', 'casey.martinez47@example.edu', 'finaid@montevallo.edu', 'Missing documents notification', 'I am reaching out regarding my financial aid application. Thank you for your time and assistance. Feel free to contact me if you need further information. Could you please provide me with an update on the current status?', 'microsoft', '823b44e9-6ca3-4050-9a45-1305b46c3a0f', '99ad4052-a220-4c44-988e-7fbdae1e159d', '2025-06-18T20:39:05.905607'
) ON CONFLICT (message_id) DO NOTHING;

INSERT INTO public.organization_inbound_messages_students (
  inbound_message_id, student_id
) VALUES (
  'aecef0ab-b65c-4a22-8d5c-4faa33726942', 'b5fc5a1f-095e-40fd-9744-7f0ae1479cc4'
);
