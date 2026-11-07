# Sigma and YARA Rules

Custom detection rules written and tested in my home SOC lab (Windows 11 VM, Sysmon, Splunk, Kali Linux). Built during #100DaysOfCybersecurity.

## Sigma rules (`sigma/`)

| Rule | Detects | MITRE ATT&CK | Log source |
|---|---|---|---|
| `encoded_powershell.yml` | PowerShell launched with an encoded command | T1059.001 | Sysmon process creation |
| `new_local_user.yml` | Local account created with `net user /add` | T1136.001 | Sysmon process creation |
| `local_user_created_4720.yml` | Local account created by any method | T1136.001 | Windows Security Event 4720 |

## YARA rules (`yara/`)

| File | What it does |
|---|---|
| `first_rule.yar` | Broad rule that matches one test phrase (kept as the "before") |
| `day93_94.yar` | Tighter rules: a marker plus payload word (case-insensitive, small files only) and a hex byte pattern |

## How I tested

**Sigma:** converted each rule to a Splunk query with `sigma-cli`, ran harmless test activity on my Windows VM, and confirmed the match in Splunk. I also ran two Atomic Red Team account-creation tests (T1136.001), and the Event 4720 rule caught both.

**YARA:** scanned harmless test files, then scanned 3,644 normal Linux programs in `/usr/bin` as a clean set. Neither rule matched any of them (0 false positives).

## Lessons learned

- My `net user` rule missed an account created with PowerShell `New-LocalUser`, because it only watched the `net` command. A reader pointed this out. A rule on Event 4720 catches both methods.
- My first YARA rule flagged a clean file that only mentioned the phrase, and missed a lowercase file. I tightened it with `nocase`, two required strings and a file-size limit.

## Limitations

- Tested in a lab only, not in a production environment.
- Sysmon fields were extracted at search time with `rex`, because the Sysmon add-on was not installed.
- The YARA test files are harmless text files I created. The clean set covers Linux programs only, so Windows files are untested.

Author: Felix (DefendWithFelix)
