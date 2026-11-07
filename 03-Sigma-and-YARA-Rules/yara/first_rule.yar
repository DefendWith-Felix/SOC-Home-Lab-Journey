rule Lab_Test_Phrase
{
    meta:
        author = "Felix (DefendWithFelix)"
        description = "Matches files containing the lab test phrase"
        date = "2026-11-01"
    strings:
        $phrase = "SigmaLabTest"
    condition:
        $phrase
}
