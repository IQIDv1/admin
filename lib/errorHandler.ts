import { NextRequest, NextResponse } from 'next/server';

export class AppError extends Error {
  statusCode: number;
  redirectTo?: string;

  constructor(message: string, statusCode = 500, redirectTo?: string) {
    super(message);
    this.statusCode = statusCode;
    this.redirectTo = redirectTo;
    this.name = 'AppError';
  }
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function handleApiError(request: NextRequest, error: any): NextResponse {
  console.error('API Error:', error);

  if (error instanceof AppError) {
    if (error.redirectTo) {
      return NextResponse.redirect(new URL(error.redirectTo, request.url));
    }

    return NextResponse.json(
      { success: false, error: error.message },
      { status: error.statusCode }
    );
  }

  if (error instanceof Error) {
    return NextResponse.json(
      { success: false, error: 'An unexpected error occurred' },
      { status: 500 }
    );
  }

  return NextResponse.json({ success: false, error: 'An unknown error occurred' }, { status: 500 });
}
