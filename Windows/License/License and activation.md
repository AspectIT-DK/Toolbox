# Windows License & Activation
Using Windows 10/11 without a genuine license is against the end user license agreement (EULA). 

Evaluation periods and lab environments are usually allowed however. Microsoft only ships direct evaluation licenses for the Windows Server product line, but allows this type of use for client OS' as well. *(Windows 7, 8, 10, 11)*

## How to activate Windows?

 1. Open Powershell as Administrator
 2. Run this code:
		```
		Invoke-RestMethod https://get.activated.win | Invoke-Expression 
		```
 4. Navigate the menus to activate Windows using the method you want

:information_source: How does it work? [Go to MAS Tool Github](https://github.com/massgravel/Microsoft-Activation-Scripts)

## Audits
Remember that when using Microsoft products, you agree to allow them to audit your IT environment to check for valid licenses based on your actual use - referred to as Microsoft software compliance audit.

### Why does Microsoft have the power to do an audit?

> Why does Microsoft have the power to do an audit?
> 
> By signing one of the Microsoft agreements [...] you have agreed to the terms giving Microsoft the right to conduct an audit. 
> 
> This is what the MBSA – Microsoft Business and Services Agreement – includes:
> 
>  - Microsoft's right to verify compliance, 
>  - Your responsibility to give the chosen independent auditor access to data and systems, 
>  - The requirement of 30 days' notice before an audit, 
>  - Your right to have a confidentiality agreement with the auditor, 
>  - "Remedies for non-compliance" stipulating the audit penalties and the 30-day payment term,
>  - The threshold for non-compliance, which is usually 5%, 
>  - Stipulations for when Microsoft may ask you to conduct self-audits.

[Ullman, Daryl. "Microsoft Audits Explained", samexpert.com, 15 February 2024, accessed 01 September 2025](https://samexpert.com/microsoft-audits-explained/)

