# build.ps1
param(
    [string]$task = "default"
)

switch ($task) {
    "generate" {
        flutter pub run build_runner build --delete-conflicting-outputs
        break
    }
    "icon" {
        flutter pub run flutter_launcher_icons
        break
    }
    "init_res"{
        dart pub global activate flutter_asset_generator
        break
    }
    "format" {
        dart format . --line-length 100
        break
    }

    "res" {
        fgen --output lib/components/resources.g.dart --no-watch --no-preview;
        & ./makefile.ps1 -task format
        break
    }


    "loc" {
        flutter gen-l10n
        &  ./makefile.ps1 -task format
        break
    }

    default {
        Write-Host "Available tasks: generate, icon, init_res, format, res, loc"
    }
}
