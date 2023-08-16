

# :defines:
#   :test:
#     :*:                                # Define TEST during compilation of all files for all test executables
#       - TEST
#     :Model:                            # Define PLATFORM_B during compilation of any test executable with Model in its filename
#       - -PLATFORM_B
#   :unity:
#     - UNITY_INCLUDE_PRINT_FORMATTED    # Define Unity configuration symbols during all test compilation
#     - UNITY_FLOAT_PRECISION=0.001f     # ...
#   :release:
#     - COM=Serial                       # Define COM for compilation of all files during release build

# :defines:
#   :test:                               # Equivalent to [test]['*'] -- i.e. same defines for all test executables
#     - -foo
#     - -Wall



class Defineinator

  constructor :configurator, :streaminator, :config_matchinator

  def setup
    @section = :defines
  end

  def defines_defined?(context:)
    return @config_matchinator.config_include?(@section, context)
  end

  def defines(context:, filepath:)
    defines = @config_matchinator.get_config(section:@section, context:context)

    if defines == nil then return []
    elsif defines.class == Array then return defines
    elsif defines.class == Hash
      @config_matchinator.validate_matchers(hash:defines, section:@section, context:context)

      return @config_matchinator.matches?(
        hash: defines,
        filepath: filepath,
        section: @section,
        context: context)
    end

    # Handle unexpected config element type
    return []
  end

end
