sealed class SolutionCheckResult {
  const SolutionCheckResult();

  factory SolutionCheckResult.fromJson(Map<String, dynamic> data) {
    if (data["tag"] == "Incorrect") {
      return IncorrectResult(data["contents"]);
    } else {
      return Correct();
    }
  }
}

class Correct implements SolutionCheckResult {}

class IncorrectResult implements SolutionCheckResult {
  final String value;

  IncorrectResult(this.value);
}
