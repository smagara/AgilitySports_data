/* fixup FIFA 2026 years */
update core.Players
set draftYear = 2026,
seasonYear = 2026
where sportCode = 'FIF'


SET NOCOUNT OFF