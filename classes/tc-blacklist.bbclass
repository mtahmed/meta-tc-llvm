# Implement blacklist/whitelist functionality for alternative toolchains
# Based on the oe-core blacklist bclass
#
# To add a blacklisted package:
#   TCBLACKLIST[pn] = 'toolchain'
#
# To blacklist everything, and whitelist a package:
#   TCBLACKLIST = 'toolchain'
#   TCWHITELIST[pn] = 'toolchain'

include conf/tc-${SECONDARYTC}-blacklist.conf

python () {
    tc = d.getVar('TOOLCHAIN', True)
    pn = d.getVar('PN', True)

    blacklist = d.getVarFlag('TCBLACKLIST', pn, True)

    if blacklist and blacklist == tc:
        raise bb.parse.SkipPackage("Recipe '%s' is blacklisted for the '%s' toolchain" % (pn, tc))

    blacklist = d.getVar('TCBLACKLIST', True)
    whitelist = d.getVarFlag('TCWHITELIST', pn, True)

    if blacklist and (not whitelist or whitelist != tc):
        raise bb.parse.SkipPackage("Recipe '%s' is blacklisted for the '%s' toolchain" % (pn, tc))
}
