USE [master]
GO

CREATE SERVER AUDIT SPECIFICATION [ServerAuditSpecification-20200415-114350]
FOR SERVER AUDIT [CAudit]
ADD (DATABASE_CHANGE_GROUP)
WITH (STATE = ON)
GO
