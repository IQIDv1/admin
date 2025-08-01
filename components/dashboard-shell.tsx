'use client';

import { useState } from 'react';
import { Mail, Settings, LogOut, PieChart } from 'lucide-react';
import { cn } from '@/lib/utils';
import { ResizableHandle, ResizablePanel, ResizablePanelGroup } from '@/components/ui/resizable';
import { Button } from '@/components/ui/button';
import { useToast } from '@/components/ui/use-toast';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu';
import { Link, Nav } from '@/components/nav';
import { TooltipProvider } from '@/components/ui/tooltip';
import type React from 'react';
import { APP_NAME } from '@/lib/constants';
import { createClient } from '@/lib/supabase/client';
import { Member } from '@/lib/types';
import { useRouter } from 'next/navigation';

interface DashboardShellProps {
  children: React.ReactNode;
  member: Member;
}

// const INIT_LINKS_STATE: Link[] = [
//   {
//     title: "Interactions",
//     label: "12",
//     icon: Mail,
//     // variant: pathname === "/" ? "default" : "ghost",
//     href: "/",
//   },
//   {
//     title: "Reggy",
//     label: "4",
//     icon: MessageSquare,
//     // variant: pathname.startsWith("/reggy") ? "default" : "ghost",
//     href: "/reggy",
//     isExpandable: true,
//     children: reggyChats,
//   },
//   {
//     title: "Analytics",
//     label: "",
//     icon: PieChart,
//     variant: pathname === "/analytics" ? "default" : "ghost",
//     href: "/analytics",
//   },
//   {
//     title: "Integrations",
//     label: "4",
//     icon: Plug,
//     variant: pathname === "/integrations" ? "default" : "ghost",
//     href: "/integrations",
//   },
//   {
//     title: "Settings",
//     label: "",
//     icon: Settings,
//     variant: pathname === "/settings" ? "default" : "ghost",
//     href: "/settings",
//   },
// ];

export default function DashboardShell({ children, member }: DashboardShellProps) {
  const supabase = createClient();
  const router = useRouter();
  const { toast } = useToast();
  const [isCollapsed, setIsCollapsed] = useState(false);

  const [links] = useState<Link[]>([
    {
      title: 'Interactions',
      label: '',
      icon: Mail,
      // variant: pathname === "/" ? "default" : "ghost",
      href: '/'
    },
    {
      title: 'Analytics',
      label: '',
      icon: PieChart,
      // variant: pathname === "/analytics" ? "default" : "ghost",
      href: '/analytics'
    },
    // {
    //   title: "Integrations",
    //   label: "4",
    //   icon: Plug,
    //   // variant: pathname === "/integrations" ? "default" : "ghost",
    //   href: "/integrations",
    // },
    {
      title: 'Settings',
      label: '',
      icon: Settings,
      // variant: pathname === "/settings" ? "default" : "ghost",
      href: '/settings'
    }
  ]);

  const handleLogout = async () => {
    const { error } = await supabase.auth.signOut();

    if (error) {
      toast({
        title: 'Failed to log out',
        variant: 'destructive'
      });
    } else {
      toast({
        title: 'Logged out successfully',
        variant: 'default'
      });
      router.push('/login');
    }
  };

  return (
    <TooltipProvider delayDuration={0}>
      <ResizablePanelGroup
        direction="horizontal"
        autoSaveId={'dashboard-layout'}
        className="h-full min-h-[100vh] max-h-[100vh] items-stretch"
      >
        <ResizablePanel
          defaultSize={20}
          collapsible={true}
          minSize={10}
          maxSize={20}
          onCollapse={() => setIsCollapsed(true)}
          onExpand={() => setIsCollapsed(false)}
          className={cn(
            'flex flex-col bg-background',
            isCollapsed && 'min-w-[50px] transition-all duration-300 ease-in-out'
          )}
        >
          <div className="flex h-[52px] items-center justify-center">
            <span
              className={cn(
                'text-xl font-bold text-primary cursor-default',
                isCollapsed ? 'hidden' : 'block'
              )}
            >
              {APP_NAME}
            </span>
          </div>
          <Nav isCollapsed={isCollapsed} links={links} />
        </ResizablePanel>
        <ResizableHandle withHandle />
        <ResizablePanel defaultSize={80}>
          <div className="flex h-full flex-col">
            <header className="bg-purple-600 flex h-12 items-center justify-between border-b px-6">
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" size="icon" className="h-8 w-8 rounded-full ml-auto">
                    {member.first_name[0]
                      ? member.first_name[0]
                      : member.email
                        ? member.email[0].toUpperCase()
                        : 'U'}
                    {/* {member .name
                      ? user.name[0]
                      : user.email
                      ? user.email[0].toUpperCase()
                      : "U"} */}
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end" className="w-[260px]">
                  <div className="px-2 py-1.5 border-b mb-1">
                    <p className="font-medium truncate">
                      {member.first_name} {member.last_name}
                    </p>
                    <p className="text-xs text-muted-foreground truncate">{member.email}</p>
                  </div>
                  {/* <DropdownMenuItem>
                <Settings className="mr-2 h-4 w-4" />
                Settings
              </DropdownMenuItem> */}
                  <DropdownMenuItem onClick={handleLogout}>
                    <LogOut className="mr-2 h-4 w-4" />
                    Log out
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
              {/* <div className="flex items-center gap-4">
                <button className="relative">
                  <Bell className="h-5 w-5 text-muted-foreground hover:text-primary" />
                  <span className="absolute -right-1 -top-1 flex h-4 w-4 items-center justify-center rounded-full bg-purple text-[10px] font-medium text-white">
                    3
                  </span>
                </button>
              </div> */}
            </header>
            <main className="flex-1 overflow-auto">
              <div className="container mx-auto p-6">{children}</div>
            </main>
          </div>
        </ResizablePanel>
      </ResizablePanelGroup>
    </TooltipProvider>
  );
}
