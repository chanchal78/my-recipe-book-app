plugins {
    id("com.android.application")
    id("kotlin-android")
    // ✅ Apply the Google Services plugin (for Firebase)
    id("com.google.gms.google-services")
    // Flutter plugin (keep it after Android/Kotlin)
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.recipe_book_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // Set the correct NDK version as per your Firebase requirements

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.recipe_book_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BOM (manages versions of Firebase libraries)
    implementation(platform("com.google.firebase:firebase-bom:32.8.0"))

    // ✅ Firestore for Firebase (used for storing and fetching recipes)
    implementation("com.google.firebase:firebase-firestore-ktx")

    // ✅ Add other Firebase libs here like auth, storage, etc.
    // implementation("com.google.firebase:firebase-auth")
    // implementation("com.google.firebase:firebase-storage")
}


