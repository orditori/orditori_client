import 'dart:io';

import 'package:github/github.dart';

final githubToken = Platform.environment['GITHUB_TOKEN'] as String;
final tag = Platform.environment['CM_TAG'] as String;

final github = GitHub(auth: Authentication.withToken(githubToken));
Future<void> main(List<String> args) async {
  final filename = args.first;

  final slug = RepositorySlug('orditori', 'orditori_client');
  final release = await github.repositories.createRelease(
    slug,
    CreateRelease(tag),
  );

  final releaseAsset = CreateReleaseAsset(
    assetData: File(filename).readAsBytesSync(),
    contentType: 'application/octet-stream',
    name: filename,
  );

  final assets = await github.repositories.uploadReleaseAssets(
    release,
    [releaseAsset],
  );

  stdout.writeln(
    'Uplaoded assets available at: \n'
    '${assets.map((e) => e.browserDownloadUrl).join('\n')}',
  );
}
