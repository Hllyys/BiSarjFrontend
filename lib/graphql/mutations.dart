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

//Station harita üzerinde gösterme
const String listChargeStationsQuery = r'''
  query ListChargeStations($locale: LocaleInputType, $limit: Int) {
    Charge_stations(locale: $locale, limit: $limit) {
      docs { id name location company(locale: $locale) { id name } }
      totalDocs page totalPages
    }
  }
''';
//Car Brand ekleme
const String createCarBrandMutation = r'''
mutation CreateCarBrand($name: String!) {
  createCarBrand(
    data: { name: $name }
  ) {
    id
    name
    createdAt
  }
}
''';
// car brands listeleme
const String getCarBrandsQuery = r'''
query GetCarBrands($page: Int!, $limit: Int!) {
  CarBrands(page: $page, limit: $limit, sort: "-createdAt") {
    docs {
      id
      name
      createdAt
      updatedAt
    }
    totalDocs
    totalPages
    hasNextPage
    hasPrevPage
    page
    limit
  }
}
''';

//car brands güncelleme
const String updateCarBrandMutation = r'''
mutation UpdateCarBrand($id: Int!, $name: String!) {
  updateCarBrand(
    id: $id,
    data: { name: $name }
  ) {
    id
    name
    createdAt
    updatedAt
  }
}
''';

//car brand dublicate
const String duplicateCarBrandMutation = r'''
mutation DuplicateCarBrand($id: Int!, $name: String!) {
  duplicateCarBrand(
    id: $id,
    data: { name: $name }
  ) {
    id
    name
    createdAt
    updatedAt
  }
}
''';

//car brand silme
const String deleteCarBrandMutation = r'''
mutation DeleteCarBrand($id: Int!) {
  deleteCarBrand(id: $id) {
    id
    name
  }
}
''';

//car model ekleme
const String createCarModelMutation = r'''
mutation CreateCarModel($name: String!, $year: Float!, $brand: Int!) {
  createCarModel(
    data: {
      name: $name
      year: $year
      brand: $brand
    }
  ) {
    id
    name
    year
    brand {
      id
      name
    }
  }
}
''';
//car model listeleme
const String getCarModelsQuery = r'''
  query GetCarModels($page: Int, $limit: Int) {
    CarModels(page: $page, limit: $limit) {
      docs {
        id
        name
        year
        brand {
          id
          name
        }
      }
      totalDocs
      totalPages
      hasNextPage
      hasPrevPage
    }
  }
''';

//update car model
const String updateCarModelMutation = r'''
mutation UpdateCarModel($id: Int!, $name: String!, $year: Float!, $brand: Int!) {
  updateCarModel(
    id: $id,
    data: {
      name: $name,
      year: $year,
      brand: $brand
    }
  ) {
    id
    name
    year
    brand {
      id
      name
    }
  }
}
''';

//delete model
const String deleteCarModelMutation = r'''
mutation DeleteCarModel($id: Int!) {
  deleteCarModel(id: $id) {
    id
    name
    year
  }
}
''';

//dublicateModel
const String duplicateCarModelMutation = r'''
mutation DuplicateCarModel($id: Int!, $data: mutationCarModelInput!) {
  duplicateCarModel(id: $id, data: $data) {
    id
    name
    year
    brand {
      id
      name
    }
    createdAt
  }
}
''';
//get car models
const String getCarModelsByBrandQuery = r'''
query GetCarModels($brandId: Int!) {
  CarModels(where: { brand: { equals: $brandId } }) {
    docs {
      id
      name
      year
      brand {
        id
        name
      }
    }
  }
}
''';
