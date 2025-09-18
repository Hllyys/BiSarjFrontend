const String loginMutation = r'''
mutation Login($email: String!, $password: String!) {
  loginUser(email: $email, password: $password) {
    exp
    token
    user {
      id
      firstName
      lastName
    }
  }
}
''';

const String registerMutation = r'''
mutation CreateUser(
  $firstName: String!, 
  $lastName: String!, 
  $email: String!, 
  $password: String!, 
  $address: String, 
  $isAdmin: Boolean
) {
  createUser(
    data: {
      firstName: $firstName,
      lastName: $lastName,
      email: $email,
      password: $password,
      address: $address,
      isAdmin: $isAdmin
    }
  ) {
    id
    firstName
    lastName
    email
    createdAt
  }
}
''';

const String forgotPasswordMutation = r'''
mutation ForgotPassword(
  $email: String!,
  $expiration: Int,
  $disableEmail: Boolean
) {
  forgotPasswordUser(
    email: $email,
    expiration: $expiration,
    disableEmail: $disableEmail
  )
}
''';
