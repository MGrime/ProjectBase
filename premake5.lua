-- Use CTRL + F to quickly modify to project

-- Defines the overall solution name
workspace "BaseProject"
    architecture "x64"
    startproject "BaseProjectApp"

    configurations
    {
        "Debug",
        "Release"
    }

-- Root output. EX: Debug-Windows-x64 etc
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Use this to specific any include directories
IncludeDir = {}

-- Place any other submodules/premake files here
group "Dependencies"

group ""

-- This is the primary project. It will build as a static lib
project "BaseProject"
    location "BaseProject"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir("bin/" .. outputdir .. "/%{prj.name}")
    objdir("bin-obj/" .. outputdir .. "/%{prj.name}")

    -- Uncomment to use a precompiled header
    --[[
    pchheader "basepch.h"
    pchsource "BaseProject/src/basepch.h"
    --]]

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.c",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{prj.name}/src"   -- Allows global includes within the project. Good for readability
    }

    -- Can be .lib files or other premake projects
    links
    {

    }

    -- Config Filters
    filter "configurations:Debug"
        defines "BASE_DEBUG"
        runtime "Debug"
        symbols "on"
        links
        {

        }
    filter "configurations:Release"
        defines "BASE_RELEASE"
        runtime "Release"
        optimize "on"
        links
        {

        }
    -- Platform Filters
    filter "system:windows"
        systemversion "latest"
        
        defines
        {
            "_CRT_SECURE_NO_WARNINGS"
        }
project "BaseProjectApp"
    location "BaseProjectApp"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir("bin/" .. outputdir .. "/%{prj.name}")
    objdir("bin-obj/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.c",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "BaseProject/src"
    }

    links
    {
        "BaseProject"
    }
    -- Config Filters
    filter "configurations:Debug"
        defines "BASE_DEBUG"
        runtime "Debug"
        symbols "on"
        links
        {

        }
    filter "configurations:Release"
        defines "BASE_RELEASE"
        runtime "Release"
        optimize "on"
        links
        {

        }
    -- Platform Filters
    filter "system:windows"
        systemversion "latest"
        
        defines
        {
            "_CRT_SECURE_NO_WARNINGS"
        }

