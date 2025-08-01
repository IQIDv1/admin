'use client';

import { useState } from 'react';
import Link from 'next/link';
import type { LucideIcon } from 'lucide-react';
import { ChevronDown, ChevronRight, MoreHorizontal, Plus, MessageSquare } from 'lucide-react';
import { usePathname } from 'next/navigation';

import { cn } from '@/lib/utils';
import { buttonVariants } from '@/components/ui/button';
import { Tooltip, TooltipContent, TooltipTrigger, TooltipProvider } from '@/components/ui/tooltip';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu';

export interface Link {
  title: string;
  label?: string;
  icon: LucideIcon;
  // variant: "default" | "ghost";
  href: string;
  isExpandable?: boolean;
  children?: {
    id: string;
    title: string;
    href: string;
  }[];
}

interface NavProps {
  isCollapsed: boolean;
  links: Link[];
}

export function Nav({ links, isCollapsed }: NavProps) {
  const pathname = usePathname();
  const [expandedItems, setExpandedItems] = useState<Record<string, boolean>>({
    Reggy: true // Start with Reggy expanded
  });

  const toggleExpand = (title: string) => {
    setExpandedItems((prev) => ({
      ...prev,
      [title]: !prev[title]
    }));
  };

  return (
    <TooltipProvider>
      <div
        data-collapsed={isCollapsed}
        // className="group flex flex-col gap-4 py-2 data-[collapsed=true]:py-2"
        className="group overflow-y-auto gap-4 py-2 data-[collapsed=true]:py-2"
      >
        <nav className="grid gap-1 px-2 group-[[data-collapsed=true]]:justify-center group-[[data-collapsed=true]]:px-2">
          {links.map((link, index) => {
            const isExpanded = expandedItems[link.title] || false;
            const variant = pathname === link.href ? 'default' : 'ghost';

            return (
              <div key={index}>
                {link.isExpandable ? (
                  <div className="flex flex-col">
                    <button
                      onClick={() => toggleExpand(link.title)}
                      className={cn(
                        buttonVariants({
                          variant,
                          size: isCollapsed ? 'icon' : 'sm'
                        }),
                        'h-9 w-full justify-start',
                        isCollapsed && 'pl-2'

                        // variant === "default" &&
                        //   "bg-background text-primary hover:bg-purple hover:text-white"
                      )}
                    >
                      <link.icon className="mr-2 h-4 w-4" />
                      {!isCollapsed && (
                        <>
                          <span className="flex-1 text-left">{link.title}</span>
                          {link.label && <span className="ml-auto text-xs">{link.label}</span>}
                          {isExpanded ? (
                            <ChevronDown className="ml-1 h-4 w-4" />
                          ) : (
                            <ChevronRight className="ml-1 h-4 w-4" />
                          )}
                        </>
                      )}
                    </button>

                    {isExpanded && !isCollapsed && link.children && (
                      <div className="ml-6 mt-1 space-y-1">
                        {link.children.map((child) => (
                          <div key={child.id} className="flex items-center">
                            <Link
                              href={child.href}
                              className={cn(
                                buttonVariants({
                                  variant: 'ghost',
                                  size: 'sm'
                                }),
                                'h-8 justify-start w-full pl-2'
                              )}
                            >
                              <MessageSquare className="mr-2 h-3 w-3" />
                              <span className="truncate">{child.title}</span>
                            </Link>
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <button className="h-8 w-8 p-0 flex items-center justify-center hover:bg-primary hover:text-primary-foreground rounded-md">
                                  <MoreHorizontal className="h-4 w-4" />
                                </button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent align="end">
                                <DropdownMenuItem>Rename</DropdownMenuItem>
                                <DropdownMenuItem>Share</DropdownMenuItem>
                                <DropdownMenuItem>Delete</DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </div>
                        ))}
                        <Link
                          href="/reggy/new"
                          className={cn(
                            buttonVariants({ variant: 'ghost', size: 'sm' }),
                            'h-8 justify-start w-full pl-2'
                          )}
                        >
                          <Plus className="mr-2 h-3 w-3" />
                          <span>New Chat</span>
                        </Link>
                      </div>
                    )}
                  </div>
                ) : isCollapsed ? (
                  <Tooltip key={index} delayDuration={0}>
                    <TooltipTrigger asChild>
                      <Link
                        href={link.href}
                        className={cn(
                          buttonVariants({
                            variant,
                            size: 'icon'
                          }),
                          'h-9 w-9'
                          // variant === "default" &&
                          //   "bg-background text-primary "
                        )}
                      >
                        <link.icon className="h-4 w-4" />
                        <span className="sr-only">{link.title}</span>
                      </Link>
                    </TooltipTrigger>
                    <TooltipContent side="right" className="flex items-center gap-4">
                      {link.title}
                      {link.label && <span className="ml-auto">{link.label}</span>}
                    </TooltipContent>
                  </Tooltip>
                ) : (
                  <Link
                    href={link.href}
                    className={cn(
                      buttonVariants({ variant, size: 'sm' }),
                      // variant === "default" &&
                      //   "bg-background text-primary hover:text-primary hover:bg-purple/10",
                      'justify-start',
                      'w-full'
                    )}
                  >
                    <link.icon className="mr-2 h-4 w-4" />
                    {link.title}
                    {link.label && <span className="ml-auto">{link.label}</span>}
                  </Link>
                )}
              </div>
            );
          })}
        </nav>
      </div>
    </TooltipProvider>
  );
}
