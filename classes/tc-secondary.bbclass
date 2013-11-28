# In order to add overrides, we need to do it later than in the layers.conf
# the only standard way is using an inherit, which requires a bbclass

# Add the necessary override
TOOLCHAINOVERRIDES = ":toolchain-${TOOLCHAIN}"
TOOLCHAINOVERRIDES[vardepsexclude] = "TOOLCHAIN"

OVERRIDES .= "${TOOLCHAINOVERRIDES}"
OVERRIDES[vardepsexclude] += "TOOLCHAINOVERRIDES"

require conf/tc-${SECONDARYTC}.conf

toolchain_create_sdk_env_script_alt () {
  set -x

  # Create environment setup script (secondary toolchain)
  orig_script=${1:-${SDK_OUTPUT}/${SDKPATH}/environment-setup-${REAL_MULTIMACH_TARGET_SYS}}
  script="$orig_script""-${SECONDARYTC}"
  rm -f $script
  touch $script
  echo ". $orig_script" | sed -e "s:${SDK_OUTPUT}::" >> $script
  if [ '${CC_toolchain-${SECONDARYTC}}' != '${''CC_toolchain-${SECONDARYTC}}' ]; then
     echo 'export CC="${CC_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${CXX_toolchain-${SECONDARYTC}}' != '${''CXX_toolchain-${SECONDARYTC}}' ]; then
     echo 'export CXX="${CXX_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${CPP_toolchain-${SECONDARYTC}}' != '${''CPP_toolchain-${SECONDARYTC}}' ]; then
     echo 'export CPP="${CPP_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${AS_toolchain-${SECONDARYTC}}' != '${''AS_toolchain-${SECONDARYTC}}' ]; then
     echo 'export AS="${AS_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${LD_toolchain-${SECONDARYTC}}' != '${''LD_toolchain-${SECONDARYTC}}' ]; then
     echo 'export LD="${LD_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${RANLIB_toolchain-${SECONDARYTC}}' != '${''RANLIB_toolchain-${SECONDARYTC}}' ]; then
     echo 'export RANLIB="${RANLIB_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${STRIP_toolchain-${SECONDARYTC}}' != '${''STRIP_toolchain-${SECONDARYTC}}' ]; then
     echo 'export STRIP="${STRIP_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${OBJCOPY_toolchain-${SECONDARYTC}}' != '${''OBJCOPY_toolchain-${SECONDARYTC}}' ]; then
     echo 'export OBJCOPY="${OBJCOPY_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${OBJDUMP_toolchain-${SECONDARYTC}}' != '${''OBJDUMP_toolchain-${SECONDARYTC}}' ]; then
     echo 'export OBJDUMP="${OBJDUMP_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${NM_toolchain-${SECONDARYTC}}' != '${''NM_toolchain-${SECONDARYTC}}' ]; then
     echo 'export NM="${NM_toolchain-${SECONDARYTC}}"' >> $script
  fi

  if [ '${CFLAGS_toolchain-${SECONDARYTC}}' != '${''CFLAGS_toolchain-${SECONDARYTC}}' ]; then
     echo 'export CFLAGS="${CFLAGS_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${CXXFLAGS_toolchain-${SECONDARYTC}}' != '${''CXXFLAGS_toolchain-${SECONDARYTC}}' ]; then
     echo 'export CXXFLAGS="${CXXFLAGS_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${LDFLAGS_toolchain-${SECONDARYTC}}' != '${''LDFLAGS_toolchain-${SECONDARYTC}}' ]; then
     echo 'export LDFLAGS="${LDFLAGS_toolchain-${SECONDARYTC}}"' >> $script
  fi
  if [ '${CPPFLAGS_toolchain-${SECONDARYTC}}' != '${''CPPFLAGS_toolchain-${SECONDARYTC}}' ]; then
     echo 'export CPPFLAGS="${CPPFLAGS_toolchain-${SECONDARYTC}}"' >> $script
  fi

  # Fixup any sysroot references
  sed -i -e "s:${STAGING_DIR_TARGET}:${SDKTARGETSYSROOT}:g" $script

  # All environment scripts require OECORE_NATIVE_SYSROOT
  echo 'export OECORE_NATIVE_SYSROOT="${SDKPATHNATIVE}"' >> $script
}

populate_sdk_image_append() {
  toolchain_create_sdk_env_script_alt ${SDK_OUTPUT}/${SDKPATH}/environment-setup-${REAL_MULTIMACH_TARGET_SYS}
}
