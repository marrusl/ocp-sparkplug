# ocp-sparkplug
Scripts to get OCP going

## Caveaut Emptor

These scripts are completely unsupported and have the usual "found it on Github support."

If you found this script because someone "official" passed this along, well, my condolences.

### Machine Config

How to use this:
- change `luks/raid.yaml` to define your raid set
- edit `luks/mkcfg.sh` and ensure that there is a line `$(mkmount <MOUNT> <RAID NAME>)` for each raid set created via Ignition
- run `make mco-luks`
- Install with the Ignition payload of `luks/raid.yaml` and the MachineConfig defintiion of `99-luks-on-raid.yaml`
