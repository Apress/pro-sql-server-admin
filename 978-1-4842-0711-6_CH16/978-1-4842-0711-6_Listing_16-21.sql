USE Chapter16MemOpt
GO

EXEC sp_changearticle
    @publication = N'Chapter16_MemOpt',
    @article = N'Customers',
    @property = N'schema_option',
    @value = 0,
    @force_invalidate_snapshot = 1,
    @force_reinit_subscription = 1;
GO
