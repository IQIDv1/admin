import React, { useState } from 'react';
import { ChevronUp, ChevronDown, CheckCircle, Clock, AlertCircle } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';
import { Badge } from '@/components/ui/badge';

// Types for context data
interface Source {
  name: string;
  details: string;
  verified: boolean;
}
interface Item {
  dataPoint: string;
  confidence?: 'high' | 'medium' | 'low';
  sources: Source[];
}
interface Category {
  category: string;
  icon: LucideIcon;
  color: string;
  iconColor: string;
  items: Item[];
}

export interface MessageContextProps {
  contextData: Category[];
}

export function MessageContext({ contextData }: MessageContextProps) {
  const [expandedSections, setExpandedSections] = useState<Record<number, boolean>>(
    contextData.reduce((acc, _, index) => ({ ...acc, [index]: true }), {})
  );

  const toggleSection = (index: number) =>
    setExpandedSections((prev) => ({ ...prev, [index]: !prev[index] }));

  const getConfidenceIcon = (confidence?: 'high' | 'medium' | 'low') => {
    switch (confidence) {
      case 'high':
        return <CheckCircle className="h-4 w-4 text-green-600" />;
      case 'medium':
        return <Clock className="h-4 w-4 text-yellow-600" />;
      case 'low':
        return <AlertCircle className="h-4 w-4 text-red-600" />;
      default:
        return null;
    }
  };

  const getConfidenceBadge = (confidence?: 'high' | 'medium' | 'low') => {
    switch (confidence) {
      case 'high':
        return (
          <Badge variant="secondary" className="bg-green-100 text-green-800 border-green-200">
            High Confidence
          </Badge>
        );
      case 'medium':
        return (
          <Badge variant="secondary" className="bg-yellow-100 text-yellow-800 border-yellow-200">
            Medium Confidence
          </Badge>
        );
      case 'low':
        return (
          <Badge variant="secondary" className="bg-red-100 text-red-800 border-red-200">
            Low Confidence
          </Badge>
        );
      default:
        return null;
    }
  };

  return (
    <div className="space-y-6">
      {contextData.map((category, index) => {
        const IconComponent = category.icon;
        const isExpanded = expandedSections[index] || false;

        return (
          <div
            key={index}
            className={`${category.color} rounded-xl border-2 shadow-sm overflow-hidden transition-all duration-200`}
            id={
              category.category === 'Previous Interaction History'
                ? 'previous-interactions-section'
                : undefined
            }
          >
            <div
              className="flex items-center p-6 cursor-pointer hover:bg-opacity-80 transition-colors"
              onClick={() => toggleSection(index)}
            >
              <div
                className={`h-8 w-8 rounded-lg ${category.iconColor} bg-white/80 flex items-center justify-center mr-3 shadow-sm`}
              >
                <IconComponent className="h-4 w-4" />
              </div>
              <h5 className="font-bold text-gray-900 text-lg flex-1">{category.category}</h5>
              <div className="ml-2">
                {isExpanded ? (
                  <ChevronUp className="h-5 w-5 text-gray-600" />
                ) : (
                  <ChevronDown className="h-5 w-5 text-gray-600" />
                )}
              </div>
            </div>

            {isExpanded && (
              <div className="space-y-4 p-6 pt-0 border-t border-gray-200 bg-white/30">
                {category.items.map((item, itemIndex) => (
                  <div
                    key={itemIndex}
                    className="bg-white/60 backdrop-blur-sm p-4 rounded-lg border border-white/40"
                  >
                    <div className="flex items-start justify-between mb-3">
                      <p className="font-semibold text-gray-800 flex-1">{item.dataPoint}</p>
                      {item.confidence && (
                        <div className="flex items-center ml-4">
                          {getConfidenceIcon(item.confidence)}
                          <div className="ml-2">{getConfidenceBadge(item.confidence)}</div>
                        </div>
                      )}
                    </div>
                    <div className="space-y-3">
                      {item.sources.map((source, sourceIndex) => (
                        <div
                          key={sourceIndex}
                          className="flex items-start bg-white/80 p-3 rounded-lg border border-gray-100"
                        >
                          <div
                            className={`w-3 h-3 rounded-full mt-1 mr-3 shadow-sm ${
                              source.verified ? 'bg-green-500' : 'bg-yellow-500'
                            }`}
                          ></div>
                          <div className="flex-1">
                            <p className="text-sm font-semibold text-gray-900">{source.name}</p>
                            <p className="text-xs text-gray-600 mt-1">{source.details}</p>
                          </div>
                          {source.verified && (
                            <CheckCircle className="h-4 w-4 text-green-600 mt-0.5" />
                          )}
                        </div>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        );
      })}
    </div>
  );
}
