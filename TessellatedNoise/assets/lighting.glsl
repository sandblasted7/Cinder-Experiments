vec3 getDiffuse( vec3 normal, vec3 lightVector ){
    float dotProduct = dot( normal, normalize(lightVector) );
    return vec3( max( dotProduct, 0.0 ) );
}

vec3 getSpecular( vec3 position, vec3 normal, vec3 lightVector, vec3 diffuse, vec3 specularColor, float shininess ){
    vec3 specular;
    vec3 halfVector = normalize( lightVector - normalize( position ) );
    float dotNormalHalf = max( dot( normal, halfVector ), 0.0 );
    
    float specularNormalization = ( shininess + 2.0001 ) / 8.0;
    
    vec3 schlick = specularColor + vec3( 1.0 - specularColor ) * pow( 1.0 - dot( lightVector, halfVector ), 5.0 );
    specular = schlick * max( pow( dotNormalHalf, shininess ), 0.0 ) * diffuse * specularNormalization * 0.25;
    
    return specular;
}

float getAttenuation( float dist, float lightRadius, float cutoff ){
    float denom = dist / lightRadius + 1.0;
    float attenuation = 1.0 / ( denom * denom );
    attenuation = ( attenuation - cutoff ) / ( 1.0 - cutoff );
    attenuation = max( attenuation, 0.0 );
    return attenuation;
}