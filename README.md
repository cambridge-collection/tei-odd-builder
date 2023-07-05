# The TEI ODD Builder

The TEI ODD builder is intended to make creating your own custom TEI RNG Schema and online documentation easier. It automatically builds RNG schemata files and html documentation for every file with an `.odd` extension in `odd` directory.

## Security Note

You will need to make security-related changes to your the repository settings of your fork for the included GitHub Actions to function.

The particular details of what you need to do are explained below in the [Instructions](#instructions), but briefly:

This repository includes two workflows (`build-rng.yml` and `static.yml`). They will be disabled for security reasons when you fork the repository. You will have to enable them (using two different settings) for the automated build and deploy to work.

- The Build Schemata and Documentation Action (`build-rng.yml`) is required. As its name implies, it builds your schemata files and documentation and then commits them back into your repository. It will need read and write permission on your repository so it can commit the built documentation and schema files.
- The Deploy to GitHub Pages Action (`static.yml`) is optional. It deploys your documentation and schemata to your project's GitHub Pages website. This is a free if your repository is public. It's a great way to ensure that transcribers always have access to the latest version of your transcription guide. If you wish to keep your repository private or do not wish to deploy to GitHub Pages, disable the Deploy to GitHub Pages (`static.yml`) as per: https://docs.github.com/en/actions/using-workflows/disabling-and-enabling-a-workflow

If you are not happy with making the required changes for these workflows to function, then tei-odd-builder likely isn't the solution for you.

## Set Up

1. Log into GitHub.com
2. Create a fork of this repository into your account by clicking https://github.com/cambridge-collection/tei-odd-builder/fork.
3. Once it has created the fork, it should take you to your copy of the repository. If not, go to your Repositories list and look for it there.
4. Once in your fork of the repository and click on **Actions** and then click on 'I understand my workflows, go ahead and enable them.' This is essential for the included workflows (Build Schemata and Documentation Action - `build-rng.yml` and Deploy to GitHub Pages Action - `static.yml` function.
4. Go to your repository's **Settings** and click on **Actions** -> **General**.
    1. Ensure **Actions Permissions** is set to 'Allow all actions and reusable workflows'
    2. Ensure **Workflow Permissions** is set to 'Read and Write Permissions'
    3. Click **Save** at the bottom of the page.
5. If you want to deploy to GitHub Pages, go to your project's **Settings** and click on **Pages**. Set the **Source** option under 'Build and Deployment' to 'GitHub Actions'. You do not need to do anything else as the action already exists within your repository.

It should now be ready to use.

## How to use

### Important
- Be sure to give your odd files an `.odd` extension.
- Do not include any spaces in the file name as this will break the build process.

You can place as many ODD files as you want in the odd directory. The Build Schemata and Documentation workflow will process each one in turn. The schemata and documentation will each take the basename of the odd file. If your repository has the following:

```
./odd
      my_custom_schema.odd
      my_second_schema.odd
```

The Action will create the following files:

```
./documentation
      my_custom_schema.html
      my_second_schema.html
./rng
      my_custom_schema.rng
      my_second_schema.rng
```

## Creating an ODD

You have many options on how to get started using an ODD file. The easiest way is to use https://roma2.tei-c.org/ and edit your ODD using its online interface. Once you are reasonably happy with it, you can 'Download your customisation as ODD' via the Download option. Place that file into the odd directory of your repo and, after confirming it has no spaces in the filename and that it has an .odd extension, you can commit and push your change. Your repo should then build a repo and customisation for you. You can always load this ODD back into Roma and edit if further. Remember to download your changes and add them back into your fork of this repository.

If you want to start coding your ODD file directly, I start by reading: <https://tei-c.org/guidelines/customization/getting-started-with-p5-odds/>.

The examples directory contains a copy of tei_all.odd. This is a copy of the maximal TEI ODD created by the TEI Consortium (https://github.com/TEIC/TEI/blob/dev/P5/Exemplars/tei_all.odd). It includes every TEI module and element available. You can always use it as a base. Place a copy in the odd directory and remove any modules and elements that you don't want.

If you are using tei_all.odd as a base, remember to rename the file (as per the stipulations above) and to change the `<schemaSpec>`'s `ident` attribute so that they reflect your project (*e.g* my_project.odd and `<schemaSpec ident=“my_project”>`.

## Using your RelaxNG schema file

The Build Schemata and Documentation Action commits the schema files and documentation into your repository. Remember to pull the latest changes after GitHub has successfully run the Actions.

You can validate your TEI files either against this local copy OR you could validate against the version contained within GitHub. Validating against the GitHub version is the preferred option, but it requires that you will be working with an active internet connection.

## Automatically validating against the GitHub RNG file in oXygen XML Editor

To validate against the file in GitHub automatically, add the following lines to your TEI file just before the `<TEI>` or `<teiCorpus>` element:

```
<?xml-model href="PATH/TO/MY/SCHEMA.RNG" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="PATH/TO/MY/SCHEMA.RNG" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

Replace `PATH/TO/MY/SCHEMA.RNG` with the *RAW* url for the file. You can find this out by following the instructions on this page: https://docs.github.com/en/repositories/working-with-files/using-files/viewing-a-file#viewing-or-copying-the-raw-file-content). It will likely be something along the lines of:

```
https://raw.githubusercontent.com/<USERNAME>/tei-odd-builder/main/rng/<ODD_BASENAME>.rng
```

**NB:**
- `<USERNAME>` will be your user or organisation name
- `<ODD_BASENAME>` will be the base filename for your ODD file.

Your document should now validate against the version contained within GitHub. That means that it will always be validating against the latest version.

## Viewing your documentation on GitHub Pages

Your documentation will be available online if you deploy the repository to your GitHub Pages site. You can find out the URL to your site by going to **Settings** and selecting **Pages**. Once you know your site's domain name, you just have to append `/documentation/<ODD_BASENAME>.html` to view your documentation.

The styling of the CSS files are the base ones used by TEI (https://github.com/TEIC/Stylesheets/tree/dev/css). They don't look overly pretty on GitHub pages, but it is at least broadly functional.

## Future Improvements

- Create dynamic homepage (index.html) that includes links to each schema file and it's documentation so you don’t need to try to figure it out for yourself.
- Improve CSS display