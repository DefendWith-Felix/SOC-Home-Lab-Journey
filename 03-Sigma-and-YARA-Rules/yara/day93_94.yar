rule Lab_Marker_And_Payload
{
    meta:
        author = "Felix (DefendWithFelix)"
        description = "Needs BOTH the marker and the payload word, ignores letter case, small files only"
        date = "2026-11-04"
    strings:
        $marker = "SigmaLabTest" nocase
        $payload = "LabPayload" nocase
    condition:
        filesize < 10KB and $marker and $payload
}

rule Lab_Hex_Pattern
{
    meta:
        author = "Felix (DefendWithFelix)"
        description = "Matches a byte pattern written in hex (the bytes for LABTEST)"
        date = "2026-11-04"
    strings:
        $hex = { 4C 41 42 54 45 53 54 }
    condition:
        $hex
}
