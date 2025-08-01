'use client';

import { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Switch } from '@/components/ui/switch';
import { Separator } from '@/components/ui/separator';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from '@/components/ui/select';
import { Slider } from '@/components/ui/slider';
import { Check, Info, Save } from 'lucide-react';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
// import { useTheme } from "next-themes";
import { THEMES } from '@/lib/constants';
import { THEMES as THEMES_TYPE } from '@/lib/types';

export default function SettingsPanel() {
  const [activeTab, setActiveTab] = useState('general');
  const [saveStatus, setSaveStatus] = useState<null | 'saving' | 'success' | 'error'>(null);

  // Form state
  const [theme, setTheme] = useState<THEMES_TYPE>(THEMES.LIGHT);
  // const { theme, setTheme } = useTheme();
  // const nextTheme = useTheme();

  // const [language, setLanguage] = useState("en");
  // const [compactView, setCompactView] = useState(false);
  const [email, setEmail] = useState('admin@university.edu');
  const [name, setName] = useState('Financial Aid Admin');

  const [responseTone, setResponseTone] = useState('professional');
  const [responseLength, setResponseLength] = useState([50]);
  // const [autoRespond, setAutoRespond] = useState(true);

  // const [newInquiryNotif, setNewInquiryNotif] = useState(true);
  // const [agentActionNotif, setAgentActionNotif] = useState(true);
  // const [reviewRequiredNotif, setReviewRequiredNotif] = useState(true);
  // const [dailySummaryNotif, setDailySummaryNotif] = useState(false);
  // const [emailNotifications, setEmailNotifications] = useState(true);
  // const [notificationEmail, setNotificationEmail] = useState(
  //   "admin@university.edu"
  // );
  // const [browserNotifications, setBrowserNotifications] = useState(true);
  // const [slackNotifications, setSlackNotifications] = useState(false);
  // const [slackWebhook, setSlackWebhook] = useState("");

  const [emailProvider, setEmailProvider] = useState('microsoft365');
  const [emailAddress, setEmailAddress] = useState('financialaid@university.edu');
  // const [sisProvider, setSisProvider] = useState("banner");
  // const [apiEndpoint, setApiEndpoint] = useState(
  //   "https://sis-api.university.edu/v1"
  // );
  // const [apiKey, setApiKey] = useState("●●●●●●●●●●●●●●●●●●●●");

  // Role permissions
  const [adminPermissions, setAdminPermissions] = useState({
    viewAll: true,
    editSettings: true,
    manageUsers: true,
    viewAnalytics: true
  });

  const [staffPermissions, setStaffPermissions] = useState({
    viewAll: true,
    editSettings: false,
    manageUsers: false,
    viewAnalytics: true
  });

  const [readonlyPermissions, setReadonlyPermissions] = useState({
    viewAll: true,
    editSettings: false,
    manageUsers: false,
    viewAnalytics: false
  });

  // Team members
  const [teamMembers, setTeamMembers] = useState([
    {
      name: 'Sarah Johnson',
      email: 'sarah.johnson@university.edu',
      role: 'admin'
    },
    {
      name: 'Michael Chen',
      email: 'michael.chen@university.edu',
      role: 'staff'
    },
    {
      name: 'Jessica Rodriguez',
      email: 'jessica.rodriguez@university.edu',
      role: 'readonly'
    }
  ]);

  const updateTeamMemberRole = (email: string, role: string) => {
    setTeamMembers(
      teamMembers.map((member) => (member.email === email ? { ...member, role } : member))
    );
  };

  const handleSave = () => {
    setSaveStatus('saving');
    // Simulate API call
    setTimeout(() => {
      setSaveStatus('success');
      setTimeout(() => setSaveStatus(null), 3000);
    }, 1000);
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div className="space-y-1">
          <h2 className="text-2xl font-semibold tracking-tight">Settings</h2>
          <p className="text-sm text-muted-foreground">
            Configure your system&apos;s behavior, notifications, and integration settings
          </p>
        </div>
        <Button
          onClick={handleSave}
          className="bg-purple hover:bg-purple/90"
          disabled={saveStatus === 'saving'}
        >
          {saveStatus === 'saving' ? (
            'Saving...'
          ) : saveStatus === 'success' ? (
            <>
              <Check className="mr-2 h-4 w-4" /> Saved
            </>
          ) : (
            <>
              <Save className="mr-2 h-4 w-4" /> Save Changes
            </>
          )}
        </Button>
      </div>

      {saveStatus === 'success' && (
        <Alert className="bg-green-50 text-green-800 border-green-200">
          <Check className="h-4 w-4 text-green-600" />
          <AlertTitle>Success</AlertTitle>
          <AlertDescription>Your settings have been saved successfully.</AlertDescription>
        </Alert>
      )}

      <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-4">
        <TabsList className="flex flex-wrap w-full min-h-fit">
          {/* <TabsList className="grid grid-cols-5 w-full"> */}
          <TabsTrigger
            value="general"
            className={`${
              activeTab === 'general' ? 'bg-purple text-white' : 'text-primary hover:bg-purple/10'
            } transition-colors flex-1`}
          >
            General
          </TabsTrigger>
          <TabsTrigger
            value="agent"
            className={`${
              activeTab === 'agent' ? 'bg-purple text-white' : 'text-primary hover:bg-purple/10'
            } transition-colors flex-1`}
          >
            Agent Behavior
          </TabsTrigger>
          {/* <TabsTrigger
            value="notifications"
            className={`${
              activeTab === "notifications"
                ? "bg-purple text-white"
                : "text-primary hover:bg-purple/10"
            } transition-colors flex-1`}
          >
            Notifications
          </TabsTrigger> */}
          <TabsTrigger
            value="integrations"
            className={`${
              activeTab === 'integrations'
                ? 'bg-purple text-white'
                : 'text-primary hover:bg-purple/10'
            } transition-colors flex-1`}
          >
            Integrations
          </TabsTrigger>
          <TabsTrigger
            value="access"
            className={`${
              activeTab === 'access' ? 'bg-purple text-white' : 'text-primary hover:bg-purple/10'
            } transition-colors flex-1`}
          >
            Access Control
          </TabsTrigger>
        </TabsList>

        {/* General Settings */}
        <TabsContent value="general" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>User Interface</CardTitle>
              <CardDescription>Customize how the dashboard looks and feels</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="theme">Theme</Label>
                <Select value={theme} onValueChange={(val: THEMES_TYPE) => setTheme(val)}>
                  <SelectTrigger id="theme">
                    <SelectValue placeholder="Select theme" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value={THEMES.LIGHT}>Light</SelectItem>
                    <SelectItem value={THEMES.DARK}>Dark</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Account Settings</CardTitle>
              <CardDescription>Manage your account information</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="email">Email Address</Label>
                <Input id="email" value={email} onChange={(e) => setEmail(e.target.value)} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="name">Display Name</Label>
                <Input id="name" value={name} onChange={(e) => setName(e.target.value)} />
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Agent Behavior Settings */}
        <TabsContent value="agent" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Response Configuration</CardTitle>
              <CardDescription>Configure how the agent responds to inquiries</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="tone">Response Tone</Label>
                <Select value={responseTone} onValueChange={setResponseTone}>
                  <SelectTrigger id="tone">
                    <SelectValue placeholder="Select tone" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="professional">Professional</SelectItem>
                    <SelectItem value="friendly">Friendly</SelectItem>
                    <SelectItem value="formal">Formal</SelectItem>
                    <SelectItem value="casual">Casual</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <Label htmlFor="response-length">Response Length</Label>
                  <span className="text-sm text-muted-foreground">Medium</span>
                </div>
                <Slider
                  id="response-length"
                  value={responseLength}
                  onValueChange={setResponseLength}
                  max={100}
                  step={1}
                  className="[&>.sliderTrack]:bg-purple"
                />
                <div className="flex justify-between text-xs text-muted-foreground">
                  <span>Concise</span>
                  <span>Detailed</span>
                </div>
              </div>
              {/* <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="auto-respond">
                    Auto-Respond to Common Inquiries
                  </Label>
                  <p className="text-sm text-muted-foreground">
                    Automatically respond without review
                  </p>
                </div>
                <Switch
                  id="auto-respond"
                  checked={autoRespond}
                  onCheckedChange={setAutoRespond}
                />
              </div> */}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Notifications Settings */}
        {/* <TabsContent value="notifications" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Notification Preferences</CardTitle>
              <CardDescription>
                Configure when and how you receive notifications
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="new-inquiry">New Inquiry Notifications</Label>
                  <p className="text-sm text-muted-foreground">
                    Receive alerts for new student inquiries
                  </p>
                </div>
                <Switch
                  id="new-inquiry"
                  checked={newInquiryNotif}
                  onCheckedChange={setNewInquiryNotif}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="agent-action">
                    Agent Action Notifications
                  </Label>
                  <p className="text-sm text-muted-foreground">
                    Receive alerts when agent takes significant actions
                  </p>
                </div>
                <Switch
                  id="agent-action"
                  checked={agentActionNotif}
                  onCheckedChange={setAgentActionNotif}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="review-required">
                    Review Required Notifications
                  </Label>
                  <p className="text-sm text-muted-foreground">
                    Receive alerts when manual review is needed
                  </p>
                </div>
                <Switch
                  id="review-required"
                  checked={reviewRequiredNotif}
                  onCheckedChange={setReviewRequiredNotif}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="daily-summary">Daily Summary</Label>
                  <p className="text-sm text-muted-foreground">
                    Receive a daily summary of agent activity
                  </p>
                </div>
                <Switch
                  id="daily-summary"
                  checked={dailySummaryNotif}
                  onCheckedChange={setDailySummaryNotif}
                />
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Delivery Methods</CardTitle>
              <CardDescription>
                Choose how you want to receive notifications
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="email-notifications">
                    Email Notifications
                  </Label>
                  <p className="text-sm text-muted-foreground">
                    Receive notifications via email
                  </p>
                </div>
                <Switch
                  id="email-notifications"
                  checked={emailNotifications}
                  onCheckedChange={setEmailNotifications}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="notification-email">Notification Email</Label>
                <Input
                  id="notification-email"
                  value={notificationEmail}
                  onChange={(e) => setNotificationEmail(e.target.value)}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="browser-notifications">
                    Browser Notifications
                  </Label>
                  <p className="text-sm text-muted-foreground">
                    Receive notifications in your browser
                  </p>
                </div>
                <Switch
                  id="browser-notifications"
                  checked={browserNotifications}
                  onCheckedChange={setBrowserNotifications}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div className="space-y-0.5">
                  <Label htmlFor="slack-notifications">
                    Slack Notifications
                  </Label>
                  <p className="text-sm text-muted-foreground">
                    Receive notifications in Slack
                  </p>
                </div>
                <Switch
                  id="slack-notifications"
                  checked={slackNotifications}
                  onCheckedChange={setSlackNotifications}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="slack-webhook">Slack Webhook URL</Label>
                <Input
                  id="slack-webhook"
                  placeholder="https://hooks.slack.com/services/..."
                  value={slackWebhook}
                  onChange={(e) => setSlackWebhook(e.target.value)}
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent> */}

        {/* Integrations Settings */}
        <TabsContent value="integrations" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Email Integration</CardTitle>
              <CardDescription>Configure your email service connection</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="email-provider">Email Provider</Label>
                <Select value={emailProvider} onValueChange={setEmailProvider}>
                  <SelectTrigger id="email-provider">
                    <SelectValue placeholder="Select provider" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="microsoft365">Microsoft 365</SelectItem>
                    <SelectItem value="gmail">Gmail</SelectItem>
                    <SelectItem value="smtp">Custom SMTP</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="email-address">Email Address</Label>
                <Input
                  id="email-address"
                  value={emailAddress}
                  onChange={(e) => setEmailAddress(e.target.value)}
                />
              </div>
              <Alert className="bg-lavender border-purple/20">
                <Info className="h-4 w-4 text-primary" />
                <AlertTitle>Connected</AlertTitle>
                <AlertDescription>
                  Your email account is connected and working properly.
                </AlertDescription>
              </Alert>
              <Button variant="outline">Reconnect Email Account</Button>
            </CardContent>
          </Card>

          {/* <Card>
            <CardHeader>
              <CardTitle>Student Information System</CardTitle>
              <CardDescription>
                Connect to your student database
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="sis-provider">SIS Provider</Label>
                <Select value={sisProvider} onValueChange={setSisProvider}>
                  <SelectTrigger id="sis-provider">
                    <SelectValue placeholder="Select provider" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="banner">Ellucian Banner</SelectItem>
                    <SelectItem value="colleague">
                      Ellucian Colleague
                    </SelectItem>
                    <SelectItem value="workday">Workday Student</SelectItem>
                    <SelectItem value="peoplesoft">
                      PeopleSoft Campus Solutions
                    </SelectItem>
                    <SelectItem value="custom">Custom API</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="api-endpoint">API Endpoint</Label>
                <Input
                  id="api-endpoint"
                  value={apiEndpoint}
                  onChange={(e) => setApiEndpoint(e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="api-key">API Key</Label>
                <Input
                  id="api-key"
                  type="password"
                  value={apiKey}
                  onChange={(e) => setApiKey(e.target.value)}
                />
              </div>
              <Alert variant="destructive">
                <AlertCircle className="h-4 w-4" />
                <AlertTitle>Connection Error</AlertTitle>
                <AlertDescription>
                  Unable to connect to the SIS API. Please check your
                  credentials.
                </AlertDescription>
              </Alert>
              <Button variant="outline">Test Connection</Button>
            </CardContent>
          </Card> */}
        </TabsContent>

        {/* Access Control Settings */}
        <TabsContent value="access" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>User Roles</CardTitle>
              <CardDescription>Manage access levels for different user types</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label>Administrator Access</Label>
                <div className="rounded-md border p-4">
                  <div className="space-y-2">
                    <div className="flex items-center justify-between">
                      <Label htmlFor="admin-view-all">View All Interactions</Label>
                      <Switch
                        id="admin-view-all"
                        checked={adminPermissions.viewAll}
                        onCheckedChange={(checked) =>
                          setAdminPermissions({
                            ...adminPermissions,
                            viewAll: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="admin-edit-settings">Edit System Settings</Label>
                      <Switch
                        id="admin-edit-settings"
                        checked={adminPermissions.editSettings}
                        onCheckedChange={(checked) =>
                          setAdminPermissions({
                            ...adminPermissions,
                            editSettings: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="admin-manage-users">Manage Users</Label>
                      <Switch
                        id="admin-manage-users"
                        checked={adminPermissions.manageUsers}
                        onCheckedChange={(checked) =>
                          setAdminPermissions({
                            ...adminPermissions,
                            manageUsers: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="admin-view-analytics">View Analytics</Label>
                      <Switch
                        id="admin-view-analytics"
                        checked={adminPermissions.viewAnalytics}
                        onCheckedChange={(checked) =>
                          setAdminPermissions({
                            ...adminPermissions,
                            viewAnalytics: checked
                          })
                        }
                      />
                    </div>
                  </div>
                </div>
              </div>

              <div className="space-y-2">
                <Label>Staff Access</Label>
                <div className="rounded-md border p-4">
                  <div className="space-y-2">
                    <div className="flex items-center justify-between">
                      <Label htmlFor="staff-view-all">View All Interactions</Label>
                      <Switch
                        id="staff-view-all"
                        checked={staffPermissions.viewAll}
                        onCheckedChange={(checked) =>
                          setStaffPermissions({
                            ...staffPermissions,
                            viewAll: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="staff-edit-settings">Edit System Settings</Label>
                      <Switch
                        id="staff-edit-settings"
                        checked={staffPermissions.editSettings}
                        onCheckedChange={(checked) =>
                          setStaffPermissions({
                            ...staffPermissions,
                            editSettings: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="staff-manage-users">Manage Users</Label>
                      <Switch
                        id="staff-manage-users"
                        checked={staffPermissions.manageUsers}
                        onCheckedChange={(checked) =>
                          setStaffPermissions({
                            ...staffPermissions,
                            manageUsers: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="staff-view-analytics">View Analytics</Label>
                      <Switch
                        id="staff-view-analytics"
                        checked={staffPermissions.viewAnalytics}
                        onCheckedChange={(checked) =>
                          setStaffPermissions({
                            ...staffPermissions,
                            viewAnalytics: checked
                          })
                        }
                      />
                    </div>
                  </div>
                </div>
              </div>

              <div className="space-y-2">
                <Label>Read-Only Access</Label>
                <div className="rounded-md border p-4">
                  <div className="space-y-2">
                    <div className="flex items-center justify-between">
                      <Label htmlFor="readonly-view-all">View All Interactions</Label>
                      <Switch
                        id="readonly-view-all"
                        checked={readonlyPermissions.viewAll}
                        onCheckedChange={(checked) =>
                          setReadonlyPermissions({
                            ...readonlyPermissions,
                            viewAll: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="readonly-edit-settings">Edit System Settings</Label>
                      <Switch
                        id="readonly-edit-settings"
                        checked={readonlyPermissions.editSettings}
                        onCheckedChange={(checked) =>
                          setReadonlyPermissions({
                            ...readonlyPermissions,
                            editSettings: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="readonly-manage-users">Manage Users</Label>
                      <Switch
                        id="readonly-manage-users"
                        checked={readonlyPermissions.manageUsers}
                        onCheckedChange={(checked) =>
                          setReadonlyPermissions({
                            ...readonlyPermissions,
                            manageUsers: checked
                          })
                        }
                      />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label htmlFor="readonly-view-analytics">View Analytics</Label>
                      <Switch
                        id="readonly-view-analytics"
                        checked={readonlyPermissions.viewAnalytics}
                        onCheckedChange={(checked) =>
                          setReadonlyPermissions({
                            ...readonlyPermissions,
                            viewAnalytics: checked
                          })
                        }
                      />
                    </div>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Team Members</CardTitle>
              <CardDescription>Manage users who have access to the system</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="rounded-md border">
                {teamMembers.map((member, index) => (
                  <div key={member.email}>
                    <div className="flex items-center justify-between p-4">
                      <div>
                        <p className="font-medium">{member.name}</p>
                        <p className="text-sm text-muted-foreground">{member.email}</p>
                      </div>
                      <div className="flex items-center gap-2">
                        <Select
                          value={member.role}
                          onValueChange={(value) => updateTeamMemberRole(member.email, value)}
                        >
                          <SelectTrigger className="w-[130px]">
                            <SelectValue placeholder="Select role" />
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="admin">Administrator</SelectItem>
                            <SelectItem value="staff">Staff</SelectItem>
                            <SelectItem value="readonly">Read-Only</SelectItem>
                          </SelectContent>
                        </Select>
                        <Button variant="outline" size="sm">
                          Remove
                        </Button>
                      </div>
                    </div>
                    {index < teamMembers.length - 1 && <Separator />}
                  </div>
                ))}
              </div>
              <Button variant="outline">Add Team Member</Button>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      <div className="flex justify-end">
        <Button
          onClick={handleSave}
          className="bg-purple hover:bg-purple/90"
          disabled={saveStatus === 'saving'}
        >
          {saveStatus === 'saving' ? (
            'Saving...'
          ) : saveStatus === 'success' ? (
            <>
              <Check className="mr-2 h-4 w-4" /> Saved
            </>
          ) : (
            <>
              <Save className="mr-2 h-4 w-4" /> Save Changes
            </>
          )}
        </Button>
      </div>
    </div>
  );
}
