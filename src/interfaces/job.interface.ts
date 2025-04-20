// src/interfaces/job.interface.ts
export interface Job {
  id: number;
  employerId: number;
  title: string;
  description: string;
  salaryMin: number;
  salaryMax: number;
  location: string;
  isRemote: boolean;
  isHybrid: boolean;
  experienceLevel: string;
  department: string;
  postedDate: Date;
  deadline: Date;
  status: 'active' | 'closed' | 'draft';
}

export interface JobSkill {
  id: number;
  jobId: number;
  skillId: number;
  importance: 'required' | 'preferred' | 'nice-to-have';
}

export interface JobFilters {
    title?: string;
    location?: string;
    salaryMin?: number;
    salaryMax?: number;
    experienceLevel?: string;
    isRemote?: boolean;
    isHybrid?: boolean;
    department?: string;
    status?: 'active' | 'closed' | 'draft';
    skills?: number[];
  }
  
  export interface JobResponse {
    id: number;
    employerId: number;
    title: string;
    description: string;
    salaryMin: number;
    salaryMax: number;
    location: string;
    isRemote: boolean;
    isHybrid: boolean;
    experienceLevel: string;
    department: string;
    postedDate: Date;
    deadline: Date;
    status: string;
    skills?: Array<{
      id: number;
      name: string;
      category: string;
      importance: string;
    }>;
    matchPercentage?: number;
  }