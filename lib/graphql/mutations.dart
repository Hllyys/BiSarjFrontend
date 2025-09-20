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
//kayıt olmak için
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
// Şifremi unuttum
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

// Kullanıcının kendisini çekmek (id lazım)
const String meUserQuery = r'''
query MeUser {
  meUser {
    token        
    user {
      id
      email
      firstName
      lastName
      address
    }
  }
}
''';

// Kullanıcı güncelleme
const String updateUserMutation = r'''
mutation UpdateUser($id: Int!, $data: mutationUserUpdateInput!) {
  updateUser(id: $id, data: $data) {
    id
    firstName
    lastName
    email
    address
    updatedAt
  }
}
''';
//logout
const String logoutMutation = r'''
mutation Logout($allSessions: Boolean) {
  logoutUser(allSessions: $allSessions)
}
''';

const String deleteUser = r'''
  mutation DeleteUser($id: Int!, $trash: Boolean) {
    deleteUser(id: $id, trash: $trash) {
      id
      email
      firstName
      lastName
    }
  }
  ''';
