# neilpiper.me Parent POM file

## What this is?

Source code for the parent pom for the Organisation

'neilpiper.me'

# How to use the Parent POM?

## Conventions to follow?

Repository is in Github team.

project.name = GIT repository name

Use git issue tracking (default)

When using `site` put published version into github pages as path `${project.name}`

## Why not test frameworks?

Allow freedom, suggest JUnit by default.

Also consider: 
* Powermock
* Mockito


## Overiding key behaviours?


# Baseline

The initial version is based on developing maven built, Java applications in the following minimum standards.


 * Maven version > 3.1
  * Release plugin 2.5.3
  * Checkstyle Plugin 2.17
  * Enforcer Plugin 1.4.1
  * Corbetura code coverage 2.7
 * Java/JDK version >= 1.8

# Validation

 * Maven & JDK at required versions (Enforcer)
 * Checkstyle - Adopt [Google checks](http://checkstyle.sourceforge.net/google_style.html) as default

# License

[MIT License](https://opensource.org/licenses/mit-license.php)

# Release Baselining (Maven snapshots, releases)

Release versions are baselined into an S3 Bucket owned by 
solveapuzzledev.  The extension [maven-s3-wagon](https://github.com/jcaddel/maven-s3-wagon) is used to communicate to S3.  

The build server will need authentication/authorisation to the S3 bucket to do this.
