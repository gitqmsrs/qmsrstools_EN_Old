using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace QMSRSTools
{
    public enum RecordsStatus
    {
        ORIGINAL = 1,
        MODIFIED = 2,
        ADDED = 3,
        REMOVED = 4,
        UNKNOWN = 5
    }

    public enum RecordMode
    {
        Current = 1,
        Archived = 2
    }

    public enum Modules
    {
        RiskManagement = 2,
        AssetManagement = 3,
        ProblemManagement = 4,
        DocumentList = 6,
        QualityRecords = 7,
        AuditManagement = 8,
        DocumentChangeRequest = 12,
        ProjectManagement = 13,
        AuditAction = 22,
        ProblemAction = 23,
        ManagementReviews = 17,
        AssetCalibration = 24,
        ManagementReviewActions = 25,
        EmployeeTraining = 26,
        AssetMaintenance = 27,
        AssetElectricalTest = 10027,
        RiskMitigationAction = 10028
    }
}
