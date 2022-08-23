///A template class being used to listen for and hold api responses, states of this
/// class is mainly responsible for showingloading dialog and finally response
/// during and after api calls
class ApiResponse {
  dynamic model = 'false';
  String errorMessage = '';
  bool isLoading = true;
  ApiResponse.loading(this.isLoading);
  ApiResponse.success(this.isLoading, this.model);
  ApiResponse.error(this.isLoading, this.errorMessage);
}
