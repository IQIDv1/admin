"use client"

import { useState } from "react"
import { Bell, LayoutDashboard, Mail, Settings, PieChart, Plug } from "lucide-react"
import { cn } from "@/lib/utils"
import { ResizableHandle, ResizablePanel, ResizablePanelGroup } from "@/components/ui/resizable"
import { Nav } from "@/components/nav"
import { TooltipProvider } from "@/components/ui/tooltip"
import { Separator } from "@/components/ui/separator"
import { usePathname } from "next/navigation"
import type React from "react"

interface DashboardShellProps {
  children: React.ReactNode
}

export function DashboardShell({ children }: DashboardShellProps) {
  const [isCollapsed, setIsCollapsed] = useState(false)
  const pathname = usePathname()

  return (
    <TooltipProvider delayDuration={0}>
      <ResizablePanelGroup direction="horizontal" className="h-full min-h-[100vh] items-stretch">
        <ResizablePanel
          defaultSize={20}
          collapsible={true}
          minSize={10}
          maxSize={20}
          onCollapse={() => setIsCollapsed(true)}
          onExpand={() => setIsCollapsed(false)}
          className={cn(
            "flex flex-col bg-background",
            isCollapsed && "min-w-[50px] transition-all duration-300 ease-in-out",
          )}
        >
          <div className="flex h-[52px] items-center justify-center border-b">
            <span className={cn("text-xl font-bold text-purple", isCollapsed ? "hidden" : "block")}>Agent</span>
          </div>
          <Separator />
          <Nav
            isCollapsed={isCollapsed}
            links={[
              {
                title: "Interactions",
                label: "12",
                icon: Mail,
                variant: pathname === "/" ? "default" : "ghost",
                href: "/",
              },
              {
                title: "Analytics",
                label: "",
                icon: PieChart,
                variant: pathname === "/analytics" ? "default" : "ghost",
                href: "/analytics",
              },
              {
                title: "Integrations",
                label: "4",
                icon: Plug,
                variant: pathname === "/integrations" ? "default" : "ghost",
                href: "/integrations",
              },
              {
                title: "Settings",
                label: "",
                icon: Settings,
                variant: pathname === "/settings" ? "default" : "ghost",
                href: "/settings",
              },
            ]}
          />
        </ResizablePanel>
        <ResizableHandle withHandle />
        <ResizablePanel defaultSize={80}>
          <div className="flex h-full flex-col">
            <header className="flex h-[52px] items-center justify-between border-b px-6">
              <div className="flex items-center gap-2">
                <h1 className="text-xl font-semibold text-purple">Dashboard</h1>
              </div>
              <div className="flex items-center gap-4">
                <button className="relative">
                  <Bell className="h-5 w-5 text-muted-foreground hover:text-purple" />
                  <span className="absolute -right-1 -top-1 flex h-4 w-4 items-center justify-center rounded-full bg-purple text-[10px] font-medium text-white">
                    3
                  </span>
                </button>
              </div>
            </header>
            <main className="flex-1 overflow-auto">
              <div className="container mx-auto p-6">{children}</div>
            </main>
          </div>
        </ResizablePanel>
      </ResizablePanelGroup>
    </TooltipProvider>
  )
}

