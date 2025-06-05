"use client";

import type React from "react";
import { useState, useEffect } from "react";
import Image from "next/image";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { APP_LOGO, APP_NAME, NEXT_PUBLIC_SITE_URL } from "@/lib/constants";
import { Loader2 } from "lucide-react";
import { useToast } from "@/components/ui/use-toast";
import { createClient } from "@/lib/supabase/client";
import { SupabaseClient } from "@supabase/supabase-js";
import { useSearchParams } from "next/navigation";
import { z } from "zod";
import {EMAIL, PASSWORD} from "@/scripts/local-user-credentials";

const loginSchema = z.object({
  email: z
    .string()
    .trim()
    .email("Invalid email address")
    .transform((val) => val.toLowerCase()),
});

const authLocalDev = async (supabase: SupabaseClient) => {
  const { data, error } = await supabase.auth.signInWithPassword({
    email: EMAIL,
    password: PASSWORD,
  });
  if (error) {
    console.error("Local auth error:", error);
    throw new Error("Local authentication failed");
  }
  if (data.user) {
    console.log("Local auth successful:", data.user);
    window.location.href = `${NEXT_PUBLIC_SITE_URL}`;
  }
};

export default function Login() {
  const { toast } = useToast();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [hasMounted, setHasMounted] = useState<boolean>(false);
  const [hasDisplayedError, setHasDisplayedError] = useState<boolean>(false);
  const supabase = createClient();
  const searchParams = useSearchParams();

  const handleLogin = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (isLoading) return;

    setIsLoading(true);

    let errorMessage = "Something went wrong";

    try {
      const formData = new FormData(e.currentTarget);
      const formObject = Object.fromEntries(formData.entries());
      const validation = loginSchema.safeParse(formObject);
      const email: string = validation.data?.email || "";
      const domain: string = email.split("@")[1] || "";

      if (!validation.success) {
        const errors = validation.error.format();
        errorMessage = errors.email?._errors[0]
          ? errors.email?._errors[0]
          : !domain
          ? "Invalid email"
          : "Something went wrong";

        throw new Error();
      }

      const response = await fetch("/api/auth/login", {
        method: "POST",
        body: JSON.stringify({ domain }),
      });

      if (!response.ok) {
        const data = await response.json();
        console.log("error msg", data);
        if (data?.error) errorMessage = data.error;
        throw new Error();
      }

      const data = await response.json();
      if (!data || !data.success) {
        errorMessage = "Invalid domain";
        throw new Error();
      }

      // Bypass SSO for local development
      const nodeEnv = process.env.NEXT_PUBLIC_NODE_ENV;
      const appEnv = process.env.NEXT_PUBLIC_APP_ENV;
      if (nodeEnv === "development" && appEnv === "local") {
        return await authLocalDev(supabase);
      }

      const { data: signInData, error: signInError } =
        await supabase.auth.signInWithSSO({
          domain,
          options: {
            redirectTo: `${NEXT_PUBLIC_SITE_URL}/api/auth/callback?attempted_email=${email}`,
          },
        });

      if (signInData?.url) window.location.href = signInData.url;
      else {
        console.log("Sign in error", signInError);
        errorMessage = "Login failed";
        throw new Error();
      }
    } catch (error) {
      console.log(error);
      toast({
        title: errorMessage,
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    setHasMounted(true);
  }, []);

  useEffect(() => {
    if (!hasMounted || hasDisplayedError) return;

    const errorParam = searchParams.get("error");

    if (errorParam) {
      let message = "Login failed";
      if (errorParam === "unauthorized") {
        message = "You must be invited to access this organization.";
      } else if (errorParam === "deactivated") {
        message =
          "Your account has been deactivated. Please contact your admin.";
      } else if (errorParam === "organization_domain") {
        message = "No organization found under your domain.";
      } else if (errorParam === "email_mismatch") {
        message =
          "The email you entered does not match the email you are logged into with your provider.";
      }
      setHasDisplayedError(true);
      console.log("error message", message);

      toast({ title: message, variant: "destructive" });
      const newParams = new URLSearchParams(window.location.search);
      newParams.delete("error");
      const newUrl =
        window.location.pathname +
        (newParams.toString() ? `?${newParams.toString()}` : "");
      window.history.replaceState({}, "", newUrl);
    }
  }, [searchParams, hasMounted, hasDisplayedError, toast]);

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-background">
      <div className="mb-8">
        <Image
          src={APP_LOGO}
          alt="IQ/ID Logo"
          width={180}
          height={60}
          priority
        />
      </div>
      <Card className="w-[350px]">
        <CardHeader>
          <CardTitle className="text-center">{APP_NAME} Login</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleLogin} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="email">Email</Label>
              <Input
                id="email"
                name="email"
                placeholder="example@university.edu"
                type="email"
                required
              />
            </div>
            <Button type="submit" className="w-full" disabled={isLoading}>
              {isLoading ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Signing in...
                </>
              ) : (
                "Sign in with SSO"
              )}
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
