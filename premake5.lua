project "date"
	kind "StaticLib"
	language "C++"
    cppdialect "C++17"    
    staticruntime "On"
    multiprocessorcompile "On"
    targetdir ("%{wks.location}/.build/%{prj.name}/%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}/bin/")
    objdir ("%{wks.location}/.build/%{prj.name}/%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}/obj")

	vpaths 
	{
    	["Header Files/*"] = { "include/**.h" },
    	["Source Files/*"] = { "src/**.cpp" }
	}

    files
	{
		"include/date/**.h",
		"src/**.cpp"
	}

	includedirs { "include" }

	filter "configurations:Debug"
        runtime "Debug"
        defines { "DEBUG" }
        symbols "On"
		
    filter "configurations:Release"
        runtime "Release"
        defines { "NDEBUG" }
        optimize "On"

    filter { "system:windows", "platforms:x64" }
        toolset "msc"
        architecture "x64"
        systemversion "latest"
        editandcontinue "Off"

    filter { "system:windows", "configurations:Debug" }
        sanitize { "Address" }
    
    filter { "system:windows", "configurations:Release" }
        buildoptions 
        {
            "/Gy"
        }
        linkoptions 
        { 
            "/OPT:REF"
        }
        
    filter "system:linux"
        toolset "clang"
        pic "On"
        linkoptions 
        {
            "-v"
        }
    filter {"system:linux", "configurations:Debug" }
        buildoptions 
        {
	    	"-g"
        }
        linkoptions 
        {
            --"-fsanitize=address"
        }
    filter {"system:linux", "configurations:Release" }
        buildoptions 
        {
            "-ffunction-sections",
            "-fdata-sections"
        }
        linkoptions 
        { 
            "-Wl"
        }
        
    filter {"system:linux", "platforms:x64" }
        architecture "x64"
    filter {"system:linux", "platforms:ARM64" }
        architecture "AARCH64"        

	filter {}